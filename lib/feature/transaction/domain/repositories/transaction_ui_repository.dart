import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/transaction/domain/entities/transaction_entity.dart';
import 'package:referral_app/feature/transaction/domain/entities/trigger_first_transaction_entity.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';

abstract class TransactionUIRepository {
  /// Get the wallet for the current user
  Future<Either<AppException, TransactionModel>> initiateTransation({
    required TransactionEntity transactionEntity,
  });
  Future<Either<AppException, bool>> triggerFirstTransactionReward({
    required TriggerFirstTransactionEntity triggerFirstTransactionEntity,
  });
  Future<Either<AppException, bool>> isFirstTransaction(String userId);
}
