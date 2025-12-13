import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/data/models/wallet_model.dart';

abstract class DashboardRepository {
  /// Get the wallet for the current user
  Future<Either<AppException, WalletModel>> getWallet(String userId);
  Future<Either<AppException, int>> getSuccessfulReferralCount(String userId);
  Future<Either<AppException, String>> getReferralCode(String userId);
  Future<Either<AppException, List<TransactionModel>>> getTransactionHistory(
    String userId, {
    int? limit,
    int? offset,
  });
}
