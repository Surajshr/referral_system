part of 'signin_cubit.dart';

enum ApiRequestStates { initial, loading, success, error }

extension Validator on SignInState {
  bool get status => Formz.validate([email, password]);

  bool get canSubmit =>
      email.isPure == false && password.isPure == false && status;
}

@freezed
abstract class SignInState with _$SignInState {
  const factory SignInState({
    @Default(ApiRequestStates.initial) ApiRequestStates? status,
    @Default('') String? message,
    @Default(EmailFormz.pure()) EmailFormz email,
    @Default(PasswordFormz.pure()) PasswordFormz password,
  }) = _SignInState;
}
