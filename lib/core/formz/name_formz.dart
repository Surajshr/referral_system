import 'package:formz/formz.dart';

class NameFormz extends FormzInput<String, NameValidationError> {
  const NameFormz.dirty(super.value) : super.dirty();
  const NameFormz.pure() : super.pure('');

  static final RegExp _namePartRegExp = RegExp(r'^[a-zA-Z]+$');

  @override
  NameValidationError? validator(String value) {
    final trimmedValue = value.trim();

    if (trimmedValue.isEmpty) {
      return NameValidationError.empty;
    }

    if (trimmedValue != value) {
      return NameValidationError.extraSpaces;
    }

    if (!trimmedValue.contains(' ')) {
      return NameValidationError.missingLastName;
    }

    final nameParts = trimmedValue
        .split(' ')
        .where((p) => p.isNotEmpty)
        .toList();

    if (nameParts.length < 2) {
      return NameValidationError.missingLastName;
    }

    for (final part in nameParts) {
      if (!_namePartRegExp.hasMatch(part)) {
        return NameValidationError.invalidFormat;
      }
    }

    if (nameParts.first.length < 2) {
      return NameValidationError.firstNameTooShort;
    }

    if (nameParts.last.length < 2) {
      return NameValidationError.lastNameTooShort;
    }

    return null;
  }
}

enum NameValidationError {
  empty('Please enter your full name'),
  missingLastName('Please enter both first and last name'),
  invalidFormat('Name can only contain letters and spaces'),
  firstNameTooShort('First name must be at least 2 characters'),
  lastNameTooShort('Last name must be at least 2 characters'),
  extraSpaces('Please remove extra spaces at the beginning or end');

  final String explain;
  const NameValidationError(this.explain);
}
