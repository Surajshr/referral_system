import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase service singleton for database operations
class SupabaseService {
  SupabaseService._();

  static SupabaseClient? _client;

  /// Initialize Supabase with URL and anon key
  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
    _client = Supabase.instance.client;
  }

  /// Get the Supabase client instance
  static SupabaseClient get client {
    if (_client == null) {
      throw Exception(
        'SupabaseService not initialized. Call initialize() first.',
      );
    }
    return _client!;
  }

  /// Direct access to auth
  static GoTrueClient get auth => client.auth;

  /// Direct access to database
  static SupabaseQueryBuilder from(String table) => client.from(table);

  /// Check if Supabase is initialized
  static bool get isInitialized => _client != null;
}
