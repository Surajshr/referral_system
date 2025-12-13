import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';

abstract class RewardTriggerRepository {
  /// Trigger first transaction reward for a referred user
  ///
  /// This will:
  /// 1. Mark the referral as successful
  /// 2. Credit wallet for both referrer (User A) and referred (User B)
  /// 3. Insert transactions for both users
  ///
  /// Returns true if reward was successfully triggered
  Future<Either<AppException, bool>> triggerFirstTransactionReward({
    required String referredUserId,
    required double referrerRewardAmount,
    required double referredRewardAmount,
    required String referrerUserEmail,
    required String referredUserEmail,
  });

  /// Check if user is eligible for first transaction reward
  Future<Either<AppException, bool>> isEligibleForFirstTransactionReward(
    String userId,
  );

  /// Get referrer user ID for a referred user
  Future<Either<AppException, String?>> getReferrerUserId(
    String referredUserId,
  );

  /// Get user email by user ID
  Future<Either<AppException, String?>> getUserEmail(String userId);
}
