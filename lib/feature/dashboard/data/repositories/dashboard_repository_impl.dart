import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/data/models/wallet_model.dart';
import 'package:referral_app/shared/domain/repositories/referral_repository.dart';
import 'package:referral_app/shared/domain/repositories/transaction_repository.dart';
import 'package:referral_app/shared/domain/repositories/wallet_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({
    required WalletRepository walletRepository,
    required ReferralRepository referralRepository,
    required TransactionRepository transactionRepository,
  }) : _walletRepository = walletRepository,
       _referralRepository = referralRepository,
       _transactionRepository = transactionRepository;

  final WalletRepository _walletRepository;
  final ReferralRepository _referralRepository;
  final TransactionRepository _transactionRepository;

  @override
  Future<Either<AppException, WalletModel>> getWallet(String userId) async {
    return await _walletRepository.getWallet(userId);
  }

  @override
  Future<Either<AppException, int>> getSuccessfulReferralCount(
    String userId,
  ) async {
    return await _referralRepository.getSuccessfulReferralCount(userId);
  }

  @override
  Future<Either<AppException, String>> getReferralCode(String userId) async {
    return await _referralRepository.getReferralCode(userId);
  }

  @override
  Future<Either<AppException, List<TransactionModel>>> getTransactionHistory(
    String userId, {
    int? limit,
    int? offset,
  }) async {
    return await _transactionRepository.getTransactionHistory(
      userId,
      limit: limit,
      offset: offset,
    );
  }
}
