part of 'signup_cubit.dart';

enum ApiRequestStates { initial, loading, success, error }

extension Validator on SignUpState {
  bool get status => Formz.validate([fullName, email, password, phone]);

  bool get canSubmit =>
      fullName.isPure == false &&
      email.isPure == false &&
      password.isPure == false &&
      phone.isPure == false &&
      status;
}

@freezed
abstract class SignUpState with _$SignUpState {
  const factory SignUpState({
    @Default(ApiRequestStates.initial) ApiRequestStates? status,
    @Default('') String? message,
    @Default(NameFormz.pure()) NameFormz fullName,
    @Default(EmailFormz.pure()) EmailFormz email,
    @Default(PasswordFormz.pure()) PasswordFormz password,
    @Default(PhoneNumberFormz.pure()) PhoneNumberFormz phone,
  }) = _SignUpState;
}
