part of 'transaction_cubit.dart';

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
  }) = _TransactionState;
}
