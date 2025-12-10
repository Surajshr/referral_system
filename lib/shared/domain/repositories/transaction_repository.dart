import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';

abstract class TransactionRepository {
  /// Insert a new transaction
  Future<Either<AppException, TransactionModel>> insertTransaction({
    required String userId,
    required double amount,
    required TransactionType type,
    String? referralId,
    String? description,
  });

  /// Get transaction history for a user
  ///
  /// Returns list of transactions sorted by date (newest first)
  Future<Either<AppException, List<TransactionModel>>> getTransactionHistory(
    String userId, {
    int? limit,
    int? offset,
  });

  /// Get a specific transaction by ID
  Future<Either<AppException, TransactionModel>> getTransactionById(
    String transactionId,
  );

  /// Get transactions by type
  Future<Either<AppException, List<TransactionModel>>> getTransactionsByType({
    required String userId,
    required TransactionType type,
  });

  /// Get total earnings from referrals
  Future<Either<AppException, double>> getTotalReferralEarnings(String userId);
}
