import 'package:referral_app/feature/transaction/domain/entities/transaction_entity.dart';

sealed class TransactionBlocEvent {
  const TransactionBlocEvent();
}

final class TransactionSendRequested extends TransactionBlocEvent {
  const TransactionSendRequested({required this.transactionEntity});

  final TransactionEntity transactionEntity;
}
