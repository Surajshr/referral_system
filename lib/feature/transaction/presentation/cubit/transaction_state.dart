part of 'transaction_cubit.dart';

extension Validator on TransactionState {
  bool get status => Formz.validate([email]);
  bool get canSubmit => email.isPure == false && amount.isNotEmpty && status;
}

@freezed
abstract class TransactionState with _$TransactionState {
  const factory TransactionState({
    @Default('') String recipient,
    @Default('') String amount,
    @Default('') String note,
    @Default(false) bool showNoteField,
    @Default(false) bool isLoading,
    @Default('') String selectedQuickAmount,
    String? errorMessage,
    String? successMessage,
    @Default(EmailFormz.pure()) EmailFormz email,
  }) = _TransactionState;
}
