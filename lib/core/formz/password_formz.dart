import 'package:formz/formz.dart';

enum PasswordValidationError { empty, invalid, tooShort, sameAsOld }

class PasswordFormz extends FormzInput<String, PasswordValidationError> {
  final String? oldPassword;
  const PasswordFormz.pure([this.oldPassword]) : super.pure('');
  const PasswordFormz.dirty(super.value, [this.oldPassword]) : super.dirty();

  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
  );

  @override
  PasswordValidationError? validator(String value) {
    if (value.isEmpty) return PasswordValidationError.empty;
    if (value.length < 8) return PasswordValidationError.tooShort;
    if (!_passwordRegExp.hasMatch(value))
      return PasswordValidationError.invalid;
    if (oldPassword != null && value == oldPassword)
      return PasswordValidationError.sameAsOld;
    return null;
  }
}

extension PasswordValidationErrorExplanation on PasswordValidationError {
  String get explain {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Please enter a password';
      case PasswordValidationError.tooShort:
        return 'Password must be at least 8 characters long';
      case PasswordValidationError.invalid:
        return 'Password must contain uppercase, lowercase, number, and special char';
      case PasswordValidationError.sameAsOld:
        return 'New password must be different from the old password';
    }
  }
}
