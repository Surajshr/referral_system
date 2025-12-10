import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/shared/data/models/referral_model.dart';

abstract class ReferralRepository {
  /// Get the referral code for a user
  Future<Either<AppException, String>> getReferralCode(String userId);

  /// Get the count of successful referrals for a user
  Future<Either<AppException, int>> getSuccessfulReferralCount(String userId);

  /// Get all referrals made by a user
  ///
  /// Returns list of referrals with optional status filter
  Future<Either<AppException, List<ReferralModel>>> getReferralList(
    String userId, {
    ReferralStatus? status,
  });

  /// Get a specific referral by ID
  Future<Either<AppException, ReferralModel>> getReferralById(
    String referralId,
  );

  /// Update referral status
  Future<Either<AppException, ReferralModel>> updateReferralStatus({
    required String referralId,
    required ReferralStatus status,
  });
}
