import 'package:referral_app/core/exceptions/app_exception.dart';

/// Centralized exception handler for repository implementations
class ExceptionHandler {
  ExceptionHandler._();

  /// Handle exceptions and convert to AppException
  static AppException handle(Object error) {
    if (error is AppException) {
      return error;
    }

    final errorMessage = error.toString().toLowerCase();

    if (errorMessage.contains('network') ||
        errorMessage.contains('connection')) {
      return NetworkException(error.toString());
    }

    if (errorMessage.contains('unauthorized') ||
        errorMessage.contains('permission')) {
      return UnauthorizedException(error.toString());
    }

    if (errorMessage.contains('not found')) {
      return NotFoundException(error.toString());
    }

    if (errorMessage.contains('duplicate') || errorMessage.contains('unique')) {
      return ValidationException(error.toString());
    }

    return DatabaseException(error.toString());
  }
}
