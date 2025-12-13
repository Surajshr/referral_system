import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/core/constants/app_constants.dart';
import 'package:referral_app/core/di/di.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/mixins/auth_mixin.dart';
import 'package:referral_app/core/route/route_imports.dart';
import 'package:referral_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:referral_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:referral_app/feature/transaction/domain/entities/trigger_first_transaction_entity.dart';
import 'package:referral_app/feature/transaction/domain/usecases/transaction/transaction_usecase.dart';
import 'package:referral_app/feature/transaction/presentation/bloc/transaction_bloc_state.dart';
import 'package:referral_app/feature/transaction/presentation/bloc/transaction_event.dart';
import 'package:referral_app/shared/domain/repositories/reward_trigger_repository.dart';

class TransactionBloc extends Bloc<TransactionBlocEvent, TransactionBlocState>
    with AuthMixin {
  TransactionBloc() : super(const TransactionInitial()) {
    on<TransactionSendRequested>(_onTransactionSendRequested);
  }
  final TransactionUsecase _transactionUsecase = di<TransactionUsecase>();
  final RewardTriggerRepository _rewardTriggerRepository =
      di<RewardTriggerRepository>();

  Future<void> _onTransactionSendRequested(
    TransactionSendRequested event,
    Emitter<TransactionBlocState> emit,
  ) async {
    try {
      emit(const TransactionLoading());

      // Initiate transaction
      final transactionResult = await _transactionUsecase.initiateTransation(
        transactionEntity: event.transactionEntity,
      );

      final transaction = await transactionResult.fold((failure) async {
        emit(TransactionFailure(failure));
        return null;
      }, (txn) async => txn);

      if (transaction == null) return;

      // Try to trigger reward if eligible (non-blocking)
      await _tryTriggerFirstTransactionReward(
        userId: event.transactionEntity.userId,
        amount: event.transactionEntity.amount,
      );
      navigatorKey.currentContext?.read<DashboardBloc>().add(
        DashboardInitRequested(userId: event.transactionEntity.userId),
      );
      emit(TransactionSuccess(transaction));
    } on AppException catch (e) {
      emit(TransactionFailure(e));
    }
  }

  /// Attempts to trigger first transaction reward if eligible
  /// Errors are silently handled - doesn't affect transaction success
  Future<void> _tryTriggerFirstTransactionReward({
    required String userId,
    required double amount,
  }) async {
    // Check if first transaction
    final isFirstResult = await _transactionUsecase.isFirstTransaction(userId);
    print('isFirstResult: $isFirstResult');
    final isFirst = isFirstResult.fold((_) => false, (value) => value);
    if (!isFirst) return;

    // Get referrer ID
    final referrerResult = await _rewardTriggerRepository.getReferrerUserId(
      userId,
    );
    print('referrerResult: $referrerResult');
    final referrerId = referrerResult.fold((_) => null, (id) => id);
    if (referrerId == null) return;

    // Get current user email
    final currentUser = await getCurrentAuthUser();
    if (currentUser == null) return;

    // Get referrer email
    final referrerEmailResult = await _transactionUsecase.getUserEmail(
      referrerId,
    );
    final referrerEmail = referrerEmailResult.fold(
      (_) => null,
      (email) => email,
    );
    if (referrerEmail == null) return;

    // Trigger reward (errors are logged internally)
    await _transactionUsecase.triggerFirstTransactionReward(
      triggerFirstTransactionEntity: TriggerFirstTransactionEntity(
        referredUserId: userId,
        referrerRewardAmount: AppConstants.refereeRewardAmount,
        referredRewardAmount: AppConstants.referralRewardAmount,
        referrerUserEmail: referrerEmail,
        referredUserEmail: currentUser.email,
      ),
    );
  }
}
