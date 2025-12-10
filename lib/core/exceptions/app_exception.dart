/// Base exception class for the application
sealed class AppException implements Exception {
  const AppException(this.message, [this.code]);

  final String message;
  final String? code;

  @override
  String toString() =>
      'AppException: $message${code != null ? ' ($code)' : ''}';
}

/// Network related exceptions
final class NetworkException extends AppException {
  const NetworkException(super.message, [super.code]);
}

/// Authentication related exceptions
final class AuthException extends AppException {
  const AuthException(super.message, [super.code]);
}

/// Database related exceptions
final class DatabaseException extends AppException {
  const DatabaseException(super.message, [super.code]);
}

/// Validation related exceptions
final class ValidationException extends AppException {
  const ValidationException(super.message, [super.code]);
}

/// Not found exceptions
final class NotFoundException extends AppException {
  const NotFoundException(super.message, [super.code]);
}

/// Unauthorized exceptions
final class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, [super.code]);
}

/// Server exceptions
final class ServerException extends AppException {
  const ServerException(super.message, [super.code]);
}

/// Unknown exceptions
final class UnknownException extends AppException {
  const UnknownException(super.message, [super.code]);
}
