import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:referral_app/core/formz/email_formz.dart';

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

  void onEmailChanged(String value) {
    final email = EmailFormz.dirty(value.trim());
    emit(state.copyWith(email: email));
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

  void clearMessages() {
    emit(state.copyWith(errorMessage: null, successMessage: null));
  }

  void reset() {
    emit(const TransactionState());
  }
}
