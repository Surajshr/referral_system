import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/transaction/domain/entities/transaction_entity.dart';
import 'package:referral_app/feature/transaction/domain/entities/trigger_first_transaction_entity.dart';
import 'package:referral_app/feature/transaction/domain/repositories/transaction_ui_repository.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/shared/domain/repositories/reward_trigger_repository.dart';
import 'package:referral_app/shared/domain/repositories/transaction_repository.dart';

class TransactionUIRepositoryImpl implements TransactionUIRepository {
  TransactionUIRepositoryImpl({
    required TransactionRepository transactionRepository,
    required RewardTriggerRepository rewardTriggerRepository,
  }) : _transactionRepository = transactionRepository,
       _rewardTriggerRepository = rewardTriggerRepository;

  final TransactionRepository _transactionRepository;
  final RewardTriggerRepository _rewardTriggerRepository;

  @override
  Future<Either<AppException, TransactionModel>> initiateTransation({
    required TransactionEntity transactionEntity,
  }) async {
    return await _transactionRepository.insertTransaction(
      userId: transactionEntity.userId,
      amount: transactionEntity.amount,
      type: transactionEntity.type,
      referralId: transactionEntity.referralId,
      description: transactionEntity.description,
      transactionToUserEmail: transactionEntity.transactionToUserEmail,
    );
  }

  @override
  Future<Either<AppException, bool>> triggerFirstTransactionReward({
    required TriggerFirstTransactionEntity triggerFirstTransactionEntity,
  }) async {
    return await _rewardTriggerRepository.triggerFirstTransactionReward(
      referredUserId: triggerFirstTransactionEntity.referredUserId,
      referrerRewardAmount: triggerFirstTransactionEntity.referrerRewardAmount,
      referredRewardAmount: triggerFirstTransactionEntity.referredRewardAmount,
      referrerUserEmail: triggerFirstTransactionEntity.referrerUserEmail,
      referredUserEmail: triggerFirstTransactionEntity.referredUserEmail,
    );
  }

  @override
  Future<Either<AppException, bool>> isFirstTransaction(String userId) async {
    return await _transactionRepository.isFirstTransaction(userId);
  }
}
