import 'package:formz/formz.dart';

enum PhoneNumberValidationError { empty, invalid, tooShort }

class PhoneNumberFormz extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumberFormz.pure() : super.pure('');
  const PhoneNumberFormz.dirty(super.value) : super.dirty();

  static final RegExp _phoneRegExp = RegExp(r'^9\d{9}$');

  @override
  PhoneNumberValidationError? validator(String value) {
    if (value.isEmpty) return PhoneNumberValidationError.empty;
    if (value.length < 10) return PhoneNumberValidationError.tooShort;
    if (!_phoneRegExp.hasMatch(value)) {
      return PhoneNumberValidationError.invalid;
    }
    return null;
  }
}

extension PhoneNumberValidationErrorExplanation on PhoneNumberValidationError {
  String get explain {
    switch (this) {
      case PhoneNumberValidationError.empty:
        return 'Please enter your phone number';
      case PhoneNumberValidationError.tooShort:
        return 'Phone number must be 10 digits long';
      case PhoneNumberValidationError.invalid:
        return 'Please enter a valid phone number starting with 9';
    }
  }
}
