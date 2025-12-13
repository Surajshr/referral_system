import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/services/supabase/supabase_service.dart';
import 'package:referral_app/core/utils/exception_handler.dart';
import 'package:referral_app/shared/data/models/referral_model.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/domain/repositories/referral_repository.dart';
import 'package:referral_app/shared/domain/repositories/reward_trigger_repository.dart';
import 'package:referral_app/shared/domain/repositories/transaction_repository.dart';
import 'package:referral_app/shared/domain/repositories/wallet_repository.dart';

/// Implementation of RewardTriggerRepository using Supabase
class RewardTriggerRepositoryImpl implements RewardTriggerRepository {
  RewardTriggerRepositoryImpl({
    required TransactionRepository transactionRepository,
    required WalletRepository walletRepository,
    required ReferralRepository referralRepository,
  }) : _transactionRepository = transactionRepository,
       _walletRepository = walletRepository,
       _referralRepository = referralRepository;
  final TransactionRepository _transactionRepository;
  final WalletRepository _walletRepository;
  final ReferralRepository _referralRepository;

  @override
  Future<Either<AppException, bool>> triggerFirstTransactionReward({
    required String referredUserId,
    required double referrerRewardAmount,
    required double referredRewardAmount,
    required String referrerUserEmail,
    required String referredUserEmail,
  }) async {
    try {
      // Validate amounts
      if (referrerRewardAmount <= 0 || referredRewardAmount <= 0) {
        return const Left(
          ValidationException('Reward amounts must be greater than 0'),
        );
      }

      // Check if user is eligible
      final isEligible = await isEligibleForFirstTransactionReward(
        referredUserId,
      );
      if (isEligible.isLeft()) {
        return isEligible.fold(
          (error) => Left(error),
          (_) => throw Exception(),
        );
      }

      final isEligibleData = isEligible.getOrElse(() => false);
      if (!isEligibleData) {
        return const Left(
          ValidationException(
            'User is not eligible for first transaction reward',
          ),
        );
      }

      // Get referrer user ID
      final referrerResult = await getReferrerUserId(referredUserId);
      if (referrerResult.isLeft()) {
        return referrerResult.fold(
          (error) => Left(error),
          (_) => throw Exception(),
        );
      }

      final referrerId = referrerResult.getOrElse(() => null);
      if (referrerId == null) {
        return const Left(NotFoundException('No referrer found for this user'));
      }

      // Get the pending referral
      final referralListResult = await _referralRepository.getReferralList(
        referrerId,
        status: ReferralStatus.pending,
      );

      if (referralListResult.isLeft()) {
        return referralListResult.fold(
          (error) => Left(error),
          (_) => throw Exception(),
        );
      }

      final referrals = referralListResult.getOrElse(() => []);
      final referral = referrals.firstWhere(
        (r) => r.refereeId == referredUserId,
      );

      // 1. Mark referral as successful
      final updateResult = await _referralRepository.updateReferralStatus(
        referralId: referral.id,
        status: ReferralStatus.successful,
      );

      if (updateResult.isLeft()) {
        return updateResult.fold(
          (error) => Left(error),
          (_) => throw Exception(),
        );
      }

      // 2. Credit wallet for referrer (User A) with transaction record
      final referrerCreditResult = await _walletRepository.creditWallet(
        userId: referrerId,
        amount: referrerRewardAmount,
        transactionType: TransactionType.referralReward,
        referralId: referral.id,
        description: 'Reward for successful referral',
      );

      if (referrerCreditResult.isLeft()) {
        // Rollback referral status
        await _referralRepository.updateReferralStatus(
          referralId: referral.id,
          status: ReferralStatus.pending,
        );
        return referrerCreditResult.fold(
          (error) => Left(error),
          (_) => throw Exception(),
        );
      }

      // 3. Credit wallet for referred user (User B) with transaction record
      final referredCreditResult = await _walletRepository.creditWallet(
        userId: referredUserId,
        amount: referredRewardAmount,
        transactionType: TransactionType.firstTransactionReward,
        referralId: referral.id,
        description: 'Welcome reward for first transaction',
      );

      if (referredCreditResult.isLeft()) {
        // Rollback referrer wallet
        await _walletRepository.debitWallet(
          userId: referrerId,
          amount: referrerRewardAmount,
        );
        // Rollback referral status
        await _referralRepository.updateReferralStatus(
          referralId: referral.id,
          status: ReferralStatus.pending,
        );
        return referredCreditResult.fold(
          (error) => Left(error),
          (_) => throw Exception(),
        );
      }

      // 4. Insert transaction for referrer (User A)
      final referrerTxnResult = await _transactionRepository.insertTransaction(
        userId: referrerId,
        amount: referrerRewardAmount,
        type: TransactionType.firstTransactionReward,
        referralId: referral.id,
        description: 'Reward for successful referral',
        transactionToUserEmail: referrerUserEmail,
      );

      referrerTxnResult.fold(
        (error) => developer.log(
          'Failed to insert referrer transaction, but wallet already credited',
          name: 'RewardTriggerRepository',
          error: error,
          level: 1000,
        ),
        (_) {},
      );

      // 5. Insert transaction for referred user (User B)
      final referredTxnResult = await _transactionRepository.insertTransaction(
        userId: referredUserId,
        amount: referredRewardAmount,
        type: TransactionType.firstTransactionReward,
        referralId: referral.id,
        description: 'Welcome reward for first transaction',
        transactionToUserEmail: referredUserEmail,
      );

      referredTxnResult.fold(
        (error) => developer.log(
          'Failed to insert referred user transaction, but wallet already credited',
          name: 'RewardTriggerRepository',
          error: error,
          level: 1000,
        ),
        (_) {},
      );

      return const Right(true);
    } catch (e, s) {
      developer.log(
        'Failed to trigger first transaction reward',
        name: 'RewardTriggerRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, bool>> isEligibleForFirstTransactionReward(
    String userId,
  ) async {
    try {
      // Check if user has any successful referrals (as referred user)
      final referralData = await SupabaseService.from('referrals')
          .select()
          .eq('referee_id', userId)
          .eq('status', ReferralStatus.successful.value)
          .maybeSingle();

      // If there's already a successful referral, user is not eligible
      if (referralData != null) {
        return const Right(false);
      }

      // Check if user has a pending referral
      final pendingReferralData = await SupabaseService.from('referrals')
          .select()
          .eq('referee_id', userId)
          .eq('status', ReferralStatus.pending.value)
          .maybeSingle();

      // User is eligible if they have a pending referral
      return Right(pendingReferralData != null);
    } catch (e, s) {
      developer.log(
        'Failed to check eligibility for first transaction reward',
        name: 'RewardTriggerRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, String?>> getReferrerUserId(
    String referredUserId, //user id of currently logged in user
  ) async {
    try {
      final referralData = await SupabaseService.from('referrals')
          .select('referrer_id')
          .eq('referee_id', referredUserId)
          .eq('status', ReferralStatus.pending.value)
          .maybeSingle();

      if (referralData == null) {
        return const Right(null);
      }

      final referrerId = referralData['referrer_id'] as String;
      return Right(referrerId);
    } catch (e, s) {
      developer.log(
        'Failed to get referrer user ID',
        name: 'RewardTriggerRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, String?>> getUserEmail(String userId) async {
    try {
      final userData = await SupabaseService.from(
        'users',
      ).select('email').eq('id', userId).maybeSingle();

      if (userData == null) {
        return const Right(null);
      }

      final email = userData['email'] as String;
      return Right(email);
    } catch (e, s) {
      developer.log(
        'Failed to get user email',
        name: 'RewardTriggerRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }
}
