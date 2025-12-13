import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/utils/exception_handler.dart';
import 'package:referral_app/feature/dashboard/domain/entities/dashboard_entity.dart';
import 'package:referral_app/feature/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/data/models/wallet_model.dart';

class DashboardUsecase {
  final DashboardRepository _dashboardRepository;

  DashboardUsecase(this._dashboardRepository);

  Future<Either<AppException, WalletModel>> getWallet(String userId) async {
    return await _dashboardRepository.getWallet(userId);
  }

  Future<Either<AppException, int>> getSuccessfulReferralCount(
    String userId,
  ) async {
    return await _dashboardRepository.getSuccessfulReferralCount(userId);
  }

  Future<Either<AppException, String>> getReferralCode(String userId) async {
    return await _dashboardRepository.getReferralCode(userId);
  }

  Future<Either<AppException, List<TransactionModel>>> getTransactionHistory(
    String userId, {
    int? limit,
    int? offset,
  }) async {
    return await _dashboardRepository.getTransactionHistory(
      userId,
      limit: limit,
      offset: offset,
    );
  }

  Future<Either<AppException, DashboardEntity>> initDashboard(
    String userId,
  ) async {
    // Validate input
    if (userId.isEmpty) {
      return const Left(ValidationException('User ID cannot be empty'));
    }

    try {
      final results = await Future.wait([
        _dashboardRepository.getWallet(userId),
        _dashboardRepository.getSuccessfulReferralCount(userId),
        _dashboardRepository.getReferralCode(userId),
        _dashboardRepository.getTransactionHistory(userId),
      ], eagerError: false);

      // Validate results array has expected length
      if (results.length != 4) {
        return const Left(
          UnknownException('Unexpected number of results returned'),
        );
      }

      final walletResult = results[0] as Either<AppException, WalletModel>;
      final referralCountResult = results[1] as Either<AppException, int>;
      final referralCodeResult = results[2] as Either<AppException, String>;
      final transactionHistoryResult =
          results[3] as Either<AppException, List<TransactionModel>>;

      return walletResult.flatMap(
        (wallet) => referralCountResult.flatMap(
          (referralCount) => referralCodeResult.flatMap(
            (referralCode) => transactionHistoryResult.map(
              (transactionHistory) => DashboardEntity(
                wallet: wallet,
                successfulReferralCount: referralCount,
                referralCode: referralCode,
                transactionHistory: transactionHistory,
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      // Handle any unexpected exceptions from Future.wait or type operations
      return Left(ExceptionHandler.handle(e));
    }
  }
}
