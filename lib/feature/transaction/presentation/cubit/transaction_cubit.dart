import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_cubit.freezed.dart';
part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(const TransactionState());

  void updateRecipient(String recipient) {
    emit(state.copyWith(recipient: recipient, errorMessage: null));
  }

  void updateAmount(String amount) {
    emit(
      state.copyWith(
        amount: amount,
        errorMessage: null,
        selectedQuickAmount: '',
      ),
    );
  }

  void updateNote(String note) {
    emit(state.copyWith(note: note));
  }

  void toggleNoteField() {
    emit(state.copyWith(showNoteField: !state.showNoteField));
  }

  void selectQuickAmount(String amount) {
    emit(
      state.copyWith(
        selectedQuickAmount: amount,
        amount: amount,
        errorMessage: null,
      ),
    );
  }

  void setMaxAmount(String maxAmount) {
    emit(
      state.copyWith(
        selectedQuickAmount: 'max',
        amount: maxAmount,
        errorMessage: null,
      ),
    );
  }

  Future<void> sendTransaction() async {
    // Clear previous messages
    emit(state.copyWith(errorMessage: null, successMessage: null));

    // Validation
    if (state.recipient.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please enter recipient details'));
      return;
    }

    final amount = double.tryParse(state.amount);
    if (amount == null || amount < 50) {
      emit(state.copyWith(errorMessage: 'Minimum transaction amount is \$50'));
      return;
    }

    // Start loading
    emit(state.copyWith(isLoading: true));

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      // Success
      emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'Transaction successful! \$20 bonus unlocked! 🎉',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Transaction failed. Please try again.',
        ),
      );
    }
  }

  void clearMessages() {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }

  void reset() {
    emit(const TransactionState());
  }
}
