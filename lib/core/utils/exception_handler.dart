import 'dart:io';

import 'package:http/http.dart' show ClientException;
import 'package:referral_app/core/exceptions/app_exception.dart';

/// Centralized exception handler for repository implementations
class ExceptionHandler {
  ExceptionHandler._();

  /// Handle exceptions and convert to AppException
  static AppException handle(Object error) {
    if (error is AppException) {
      return error;
    }

    // Handle network errors
    if (error is SocketException) {
      return const NetworkException(
        'Unable to connect to the server. Please check your internet connection',
      );
    }

    if (error is ClientException) {
      return const NetworkException(
        'Network error occurred. Please check your internet connection',
      );
    }

    final errorMessage = error.toString().toLowerCase();

    // Check for DNS resolution failures
    if (errorMessage.contains('failed host lookup') ||
        errorMessage.contains('no address associated')) {
      return const NetworkException(
        'Unable to connect to the server. Please check your internet connection',
      );
    }

    if (errorMessage.contains('network') ||
        errorMessage.contains('connection') ||
        errorMessage.contains('socket')) {
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
