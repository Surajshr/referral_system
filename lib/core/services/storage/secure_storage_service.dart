import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:referral_app/core/constants/storage_constant.dart';

/// Secure storage service for storing sensitive data
class SecureStorageService {
  SecureStorageService(this._storage);

  final FlutterSecureStorage _storage;

  /// Save user session
  Future<void> saveSession({
    required String userId,
    required String sessionToken,
    String? refreshToken,
  }) async {
    await Future.wait([
      _storage.write(key: StorageConstant.kyUserId, value: userId),
      _storage.write(key: StorageConstant.kSessionToken, value: sessionToken),
      if (refreshToken != null)
        _storage.write(key: StorageConstant.kRefreshToken, value: refreshToken),
    ]);
  }

  /// Get user ID
  Future<String?> getUserId() async {
    return _storage.read(key: StorageConstant.kyUserId);
  }

  /// Get session token
  Future<String?> getSessionToken() async {
    return _storage.read(key: StorageConstant.kSessionToken);
  }

  /// Get refresh token
  Future<String?> getRefreshToken() async {
    return _storage.read(key: StorageConstant.kRefreshToken);
  }

  /// Check if user has valid session
  Future<bool> hasValidSession() async {
    final userId = await getUserId();
    final token = await getSessionToken();
    return userId != null && token != null;
  }

  /// Clear all session data
  Future<void> clearSession() async {
    await Future.wait([
      _storage.delete(key: StorageConstant.kyUserId),
      _storage.delete(key: StorageConstant.kSessionToken),
      _storage.delete(key: StorageConstant.kRefreshToken),
    ]);
  }

  /// Clear all storage
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// Write custom key-value pair
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Read custom key
  Future<String?> read(String key) async {
    return _storage.read(key: key);
  }

  /// Delete custom key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }
}
