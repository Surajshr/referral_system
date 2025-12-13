import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/transaction/domain/entities/transaction_entity.dart';
import 'package:referral_app/feature/transaction/domain/entities/trigger_first_transaction_entity.dart';
import 'package:referral_app/feature/transaction/domain/repositories/transaction_ui_repository.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/domain/repositories/reward_trigger_repository.dart';

class TransactionUsecase {
  final TransactionUIRepository _transactionUIRepository;
  final RewardTriggerRepository _rewardTriggerRepository;

  TransactionUsecase(
    this._transactionUIRepository,
    this._rewardTriggerRepository,
  );

  Future<Either<AppException, TransactionModel>> initiateTransation({
    required TransactionEntity transactionEntity,
  }) async {
    return await _transactionUIRepository.initiateTransation(
      transactionEntity: transactionEntity,
    );
  }

  Future<Either<AppException, bool>> triggerFirstTransactionReward({
    required TriggerFirstTransactionEntity triggerFirstTransactionEntity,
  }) async {
    return await _transactionUIRepository.triggerFirstTransactionReward(
      triggerFirstTransactionEntity: triggerFirstTransactionEntity,
    );
  }

  Future<Either<AppException, bool>> isFirstTransaction(String userId) async {
    return await _transactionUIRepository.isFirstTransaction(userId);
  }

  /// Get user email by user ID
  Future<Either<AppException, String?>> getUserEmail(String userId) async {
    return await _rewardTriggerRepository.getUserEmail(userId);
  }
}
