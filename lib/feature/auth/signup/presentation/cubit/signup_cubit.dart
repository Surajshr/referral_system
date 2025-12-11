import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:referral_app/core/formz/formz_exports.dart';

part 'signup_cubit.freezed.dart';
part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  final ValueNotifier<bool> isPasswordVisible = ValueNotifier(false);

  void togglePassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void onFullNameChanged(String value) {
    final fullName = NameFormz.dirty(value);
    emit(state.copyWith(fullName: fullName));
  }

  void onEmailChanged(String value) {
    final email = EmailFormz.dirty(value.trim());
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String value) {
    final password = PasswordFormz.dirty(value);
    emit(state.copyWith(password: password));
  }

  void onPhoneChanged(String value) {
    final phone = PhoneNumberFormz.dirty(value);
    emit(state.copyWith(phone: phone));
  }
}
