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
    required WalletRepository walletRepository,
    required TransactionRepository transactionRepository,
    required ReferralRepository referralRepository,
  }) : _walletRepository = walletRepository,
       _transactionRepository = transactionRepository,
       _referralRepository = referralRepository;

  final WalletRepository _walletRepository;
  final TransactionRepository _transactionRepository;
  final ReferralRepository _referralRepository;

  @override
  Future<Either<AppException, bool>> triggerFirstTransactionReward({
    required String referredUserId,
    required double referrerRewardAmount,
    required double referredRewardAmount,
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

      // 2. Credit wallet for referrer (User A)
      final referrerCreditResult = await _walletRepository.creditWallet(
        userId: referrerId,
        amount: referrerRewardAmount,
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

      // 3. Credit wallet for referred user (User B)
      final referredCreditResult = await _walletRepository.creditWallet(
        userId: referredUserId,
        amount: referredRewardAmount,
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
    String referredUserId,
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
}
