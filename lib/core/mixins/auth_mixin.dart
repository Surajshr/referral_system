import 'package:referral_app/core/di/di.dart';
import 'package:referral_app/shared/data/models/user_model.dart';
import 'package:referral_app/shared/domain/repositories/auth_repository.dart';

mixin AuthMixin {
  AuthRepository get _authRepository => di<AuthRepository>();

  /// Check if user is authenticated by validating the session
  ///
  /// Returns true if session is valid and not expired
  Future<bool> isAuthenticated() async {
    final result = await _authRepository.checkSession();
    return result.isRight();
  }

  /// Check if user has a valid session
  ///
  /// This is a lightweight check that only verifies if session exists
  /// without validating it against the database
  Future<bool> hasSession() async {
    final result = await _authRepository.getCurrentUser();
    return result.fold((_) => false, (user) => user != null);
  }

  /// Get current authenticated user
  ///
  /// Returns null if no user is authenticated or session is invalid
  Future<UserModel?> getCurrentAuthUser() async {
    final result = await _authRepository.getCurrentUser();
    return result.fold((_) => null, (user) => user);
  }

  /// Validate and get user from session
  ///
  /// This validates the session against the database and returns
  /// the user if session is valid. Returns null if invalid.
  Future<UserModel?> validateAndGetUser() async {
    final result = await _authRepository.checkSession();
    return result.fold((_) => null, (user) => user);
  }

  /// Logout current user
  ///
  /// Clears session from both database and local storage
  Future<bool> logout() async {
    final result = await _authRepository.logout();
    return result.isRight();
  }
}
