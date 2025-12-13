import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';

sealed class TransactionBlocState {
  const TransactionBlocState();
}

final class TransactionInitial extends TransactionBlocState {
  const TransactionInitial();
}

final class TransactionLoading extends TransactionBlocState {
  const TransactionLoading();
}

final class TransactionSuccess extends TransactionBlocState {
  const TransactionSuccess(this.transaction);

  final TransactionModel transaction;
}

final class TransactionFailure extends TransactionBlocState {
  const TransactionFailure(this.exception);

  final AppException exception;
}
