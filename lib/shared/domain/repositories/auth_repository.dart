import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/shared/data/models/session_model.dart';
import 'package:referral_app/shared/data/models/user_model.dart';

abstract class AuthRepository {
  /// Register a new user
  ///
  /// Returns the created user with session information
  Future<Either<AppException, UserModel>> registerUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    String? referralCode,
  });

  /// Login user with email and password
  ///
  /// Returns the user with session information
  Future<Either<AppException, UserModel>> login({
    required String email,
    required String password,
  });

  /// Check if the current session is valid
  ///
  /// Returns the user if session is valid
  Future<Either<AppException, UserModel>> checkSession();

  /// Logout the current user
  ///
  /// Clears session from database and local storage
  Future<Either<AppException, Unit>> logout();

  /// Get current user from local session
  ///
  /// Returns null if no session exists
  Future<Either<AppException, UserModel?>> getCurrentUser();

  /// Refresh session token
  Future<Either<AppException, SessionModel>> refreshSession();
}
