import 'package:formz/formz.dart';

enum EmailValidationError { empty, invalid, tooLong }

class EmailFormz extends FormzInput<String, EmailValidationError> {
  const EmailFormz.pure() : super.pure('');

  const EmailFormz.dirty(super.value) : super.dirty();

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) return EmailValidationError.empty;
    if (value.length > 254) return EmailValidationError.tooLong;
    if (!_emailRegExp.hasMatch(value)) return EmailValidationError.invalid;
    return null;
  }
}

extension EmailValidationErrorExplanation on EmailValidationError {
  String get explain {
    switch (this) {
      case EmailValidationError.empty:
        return 'Please enter your email';
      case EmailValidationError.invalid:
        return 'Please check the email format';
      case EmailValidationError.tooLong:
        return 'Email must not exceed 254 characters';
    }
  }
}
