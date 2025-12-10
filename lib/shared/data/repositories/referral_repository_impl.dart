import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/services/supabase/supabase_service.dart';
import 'package:referral_app/core/utils/exception_handler.dart';
import 'package:referral_app/shared/data/models/referral_model.dart';
import 'package:referral_app/shared/domain/repositories/referral_repository.dart';

/// Implementation of ReferralRepository using Supabase
class ReferralRepositoryImpl implements ReferralRepository {
  @override
  Future<Either<AppException, String>> getReferralCode(String userId) async {
    try {
      final userData = await SupabaseService.from(
        'users',
      ).select('referral_code').eq('id', userId).single();

      final referralCode = userData['referral_code'] as String;
      return Right(referralCode);
    } catch (e, s) {
      developer.log(
        'Failed to get referral code',
        name: 'ReferralRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, int>> getSuccessfulReferralCount(
    String userId,
  ) async {
    try {
      final data = await SupabaseService.from('referrals')
          .select('id')
          .eq('referrer_id', userId)
          .eq('status', ReferralStatus.successful.value);

      final count = (data as List).length;
      return Right(count);
    } catch (e, s) {
      developer.log(
        'Failed to get successful referral count',
        name: 'ReferralRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, List<ReferralModel>>> getReferralList(
    String userId, {
    ReferralStatus? status,
  }) async {
    try {
      final baseQuery = SupabaseService.from(
        'referrals',
      ).select().eq('referrer_id', userId);

      final query = status != null
          ? baseQuery.eq('status', status.value)
          : baseQuery;

      final data = await query.order('created_at', ascending: false);

      final referrals = (data as List)
          .map((json) => ReferralModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(referrals);
    } catch (e, s) {
      developer.log(
        'Failed to get referral list',
        name: 'ReferralRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, ReferralModel>> getReferralById(
    String referralId,
  ) async {
    try {
      final data = await SupabaseService.from(
        'referrals',
      ).select().eq('id', referralId).single();

      final referral = ReferralModel.fromJson(data);
      return Right(referral);
    } catch (e, s) {
      developer.log(
        'Failed to get referral by ID',
        name: 'ReferralRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, ReferralModel>> updateReferralStatus({
    required String referralId,
    required ReferralStatus status,
  }) async {
    try {
      final updateData = <String, dynamic>{'status': status.value};

      // If status is successful, set completed_at
      if (status == ReferralStatus.successful) {
        updateData['completed_at'] = DateTime.now().toIso8601String();
      }

      final data = await SupabaseService.from(
        'referrals',
      ).update(updateData).eq('id', referralId).select().single();

      final referral = ReferralModel.fromJson(data);
      return Right(referral);
    } catch (e, s) {
      developer.log(
        'Failed to update referral status',
        name: 'ReferralRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }
}
