import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' show ClientException;
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/services/storage/secure_storage_service.dart';
import 'package:referral_app/core/services/supabase/supabase_service.dart';
import 'package:referral_app/core/utils/exception_handler.dart';
import 'package:referral_app/shared/data/models/referral_model.dart';
import 'package:referral_app/shared/data/models/session_model.dart';
import 'package:referral_app/shared/data/models/user_model.dart';
import 'package:referral_app/shared/domain/repositories/auth_repository.dart';
import 'package:uuid/uuid.dart';

/// Implementation of AuthRepository using Supabase
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required SecureStorageService secureStorage})
    : _secureStorage = secureStorage;

  final SecureStorageService _secureStorage;
  static const _uuid = Uuid();

  @override
  Future<Either<AppException, UserModel>> registerUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    String? referralCode,
  }) async {
    try {
      // Validate inputs
      if (fullName.isEmpty ||
          email.isEmpty ||
          phone.isEmpty ||
          password.isEmpty) {
        return const Left(ValidationException('All fields are required'));
      }

      // Check if Supabase is initialized
      if (!SupabaseService.isInitialized) {
        return const Left(
          NetworkException(
            'Unable to connect to the server. Please check your internet connection',
          ),
        );
      }

      // Validate referral code if provided
      String? referrerId;
      if (referralCode != null && referralCode.isNotEmpty) {
        try {
          final referrerData = await SupabaseService.from(
            'users',
          ).select('id').eq('referral_code', referralCode).maybeSingle();

          if (referrerData == null) {
            return const Left(
              ValidationException(
                'Invalid referral code. Please check and try again.',
              ),
            );
          }
          referrerId = referrerData['id'] as String;
        } on ClientException catch (e) {
          developer.log(
            'Network error validating referral code',
            name: 'AuthRepository',
            error: e,
          );
          return const Left(
            NetworkException(
              'Unable to verify referral code. Please check your internet connection',
            ),
          );
        }
      }

      // Check if user already exists
      final existingUser = await SupabaseService.from(
        'users',
      ).select().or('email.eq.$email,phone.eq.$phone').maybeSingle();

      if (existingUser != null) {
        return const Left(
          ValidationException('User with this email or phone already exists'),
        );
      }

      // Generate unique referral code
      final newReferralCode = await _generateUniqueReferralCode();

      // Hash password
      final hashedPassword = _hashPassword(password);

      // Create user ID
      final userId = _uuid.v4();

      // Insert user
      final userData = await SupabaseService.from('users')
          .insert({
            'id': userId,
            'full_name': fullName,
            'email': email,
            'phone': phone,
            'password': hashedPassword,
            'referral_code': newReferralCode,
          })
          .select()
          .single();

      final user = UserModel.fromJson(userData);

      // Create wallet for user
      await SupabaseService.from(
        'wallet',
      ).insert({'user_id': userId, 'balance': 0.0});

      // If referral code provided, create referral entry
      if (referrerId != null) {
        // Insert referral as PENDING
        await SupabaseService.from('referrals').insert({
          'id': _uuid.v4(),
          'referrer_id': referrerId,
          'referee_id': userId,
          'status': ReferralStatus.pending.value,
        });
      }

      // Create session
      final session = await _createSession(userId);

      // Save session to secure storage
      await _secureStorage.saveSession(
        userId: userId,
        sessionToken: session.token,
        refreshToken: session.refreshToken,
      );

      return Right(user);
    } catch (e, s) {
      developer.log(
        'Failed to register user',
        name: 'AuthRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Validate inputs
      if (email.isEmpty || password.isEmpty) {
        return const Left(
          ValidationException('Email and password are required'),
        );
      }

      // Check if Supabase is initialized
      if (!SupabaseService.isInitialized) {
        return const Left(
          NetworkException(
            'Unable to connect to the server. Please check your internet connection',
          ),
        );
      }

      // Hash password
      final hashedPassword = _hashPassword(password);

      // Find user by email and password
      final userData = await SupabaseService.from('users')
          .select()
          .eq('email', email)
          .eq('password', hashedPassword)
          .maybeSingle();

      if (userData == null) {
        return const Left(AuthException('Invalid email or password'));
      }

      final user = UserModel.fromJson(userData);

      // Create new session
      final session = await _createSession(user.id);

      // Save session to secure storage
      await _secureStorage.saveSession(
        userId: user.id,
        sessionToken: session.token,
        refreshToken: session.refreshToken,
      );

      return Right(user);
    } catch (e, s) {
      developer.log(
        'Failed to login',
        name: 'AuthRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, UserModel>> checkSession() async {
    try {
      // Get session token from secure storage
      final sessionToken = await _secureStorage.getSessionToken();
      if (sessionToken == null) {
        return const Left(UnauthorizedException('No session found'));
      }

      // Check if Supabase is initialized
      if (!SupabaseService.isInitialized) {
        developer.log(
          'Supabase not initialized during session check',
          name: 'AuthRepository',
        );
        // Return UnauthorizedException instead of NetworkException
        // to prevent infinite retry loops in splash screen
        return const Left(
          UnauthorizedException('Unable to verify session. Please login again'),
        );
      }

      // Validate session in database
      final sessionData = await SupabaseService.from(
        'sessions',
      ).select().eq('token', sessionToken).maybeSingle();

      if (sessionData == null) {
        await _secureStorage.clearSession();
        return const Left(UnauthorizedException('Invalid session'));
      }

      final session = SessionModel.fromJson(sessionData);

      // Check if session is expired
      if (session.isExpired) {
        await _deleteSession(session.token);
        await _secureStorage.clearSession();
        return const Left(UnauthorizedException('Session expired'));
      }

      // Get user data
      final userData = await SupabaseService.from(
        'users',
      ).select().eq('id', session.userId).single();

      final user = UserModel.fromJson(userData);

      return Right(user);
    } catch (e, s) {
      developer.log(
        'Failed to check session',
        name: 'AuthRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, Unit>> logout() async {
    try {
      // Get session token
      final sessionToken = await _secureStorage.getSessionToken();

      if (sessionToken != null) {
        // Delete session from database
        await _deleteSession(sessionToken);
      }

      // Clear secure storage
      await _secureStorage.clearSession();

      return const Right(unit);
    } catch (e, s) {
      developer.log(
        'Failed to logout',
        name: 'AuthRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, UserModel?>> getCurrentUser() async {
    try {
      final userId = await _secureStorage.getUserId();
      if (userId == null) {
        return const Right(null);
      }

      final userData = await SupabaseService.from(
        'users',
      ).select().eq('id', userId).maybeSingle();

      if (userData == null) {
        await _secureStorage.clearSession();
        return const Right(null);
      }

      final user = UserModel.fromJson(userData);
      return Right(user);
    } catch (e, s) {
      developer.log(
        'Failed to get current user',
        name: 'AuthRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  @override
  Future<Either<AppException, SessionModel>> refreshSession() async {
    try {
      final refreshToken = await _secureStorage.getRefreshToken();
      if (refreshToken == null) {
        return const Left(UnauthorizedException('No refresh token found'));
      }

      // In a real app, you would validate the refresh token
      // and create a new session. For simplicity, we'll get the user ID
      final userId = await _secureStorage.getUserId();
      if (userId == null) {
        return const Left(UnauthorizedException('No user ID found'));
      }

      // Delete old session
      final oldToken = await _secureStorage.getSessionToken();
      if (oldToken != null) {
        await _deleteSession(oldToken);
      }

      // Create new session
      final session = await _createSession(userId);

      // Save new session
      await _secureStorage.saveSession(
        userId: userId,
        sessionToken: session.token,
        refreshToken: session.refreshToken,
      );

      return Right(session);
    } catch (e, s) {
      developer.log(
        'Failed to refresh session',
        name: 'AuthRepository',
        error: e,
        stackTrace: s,
        level: 1000,
      );
      return Left(ExceptionHandler.handle(e));
    }
  }

  // Helper methods

  /// Generate a unique referral code
  Future<String> _generateUniqueReferralCode() async {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random.secure();

    while (true) {
      final code = String.fromCharCodes(
        Iterable.generate(
          8,
          (_) => chars.codeUnitAt(random.nextInt(chars.length)),
        ),
      );

      // Check if code already exists
      final existing = await SupabaseService.from(
        'users',
      ).select('id').eq('referral_code', code).maybeSingle();

      if (existing == null) {
        return code;
      }
    }
  }

  /// Hash password using SHA-256
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// Create a new session for user
  Future<SessionModel> _createSession(String userId) async {
    final sessionId = _uuid.v4();
    final token = _uuid.v4();
    final refreshToken = _uuid.v4();
    final expiresAt = DateTime.now().add(const Duration(days: 30));

    final sessionData = await SupabaseService.from('sessions')
        .insert({
          'id': sessionId,
          'user_id': userId,
          'token': token,
          'refresh_token': refreshToken,
          'expires_at': expiresAt.toIso8601String(),
        })
        .select()
        .single();

    return SessionModel.fromJson(sessionData);
  }

  /// Delete a session by token
  Future<void> _deleteSession(String token) async {
    await SupabaseService.from('sessions').delete().eq('token', token);
  }
}
