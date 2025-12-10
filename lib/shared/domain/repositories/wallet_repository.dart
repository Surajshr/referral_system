import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/shared/data/models/wallet_model.dart';

/// Abstract repository for wallet operations
abstract class WalletRepository {
  /// Get wallet for a user
  Future<Either<AppException, WalletModel>> getWallet(String userId);

  /// Get wallet balance for a user
  Future<Either<AppException, double>> getWalletBalance(String userId);

  /// Credit wallet with amount
  ///
  /// Returns updated wallet
  Future<Either<AppException, WalletModel>> creditWallet({
    required String userId,
    required double amount,
  });

  /// Debit wallet with amount
  ///
  /// Returns updated wallet
  Future<Either<AppException, WalletModel>> debitWallet({
    required String userId,
    required double amount,
  });

  /// Create a new wallet for user
  Future<Either<AppException, WalletModel>> createWallet(String userId);
}
