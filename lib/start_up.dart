import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:referral_app/core/constants/environment_constants.dart';
import 'package:referral_app/core/di/di.dart';
import 'package:referral_app/core/services/supabase/supabase_service.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeServices();
}

Future<void> _initializeServices() async {
  try {
    // Initialize Supabase first with error handling
    await SupabaseService.initialize(
      url: EnvironmentConstants.supabaseUrl,
      anonKey: EnvironmentConstants.supabaseAnonKey,
    );
  } catch (e, stackTrace) {
    developer.log(
      'Failed to initialize Supabase: $e',
      name: 'StartUp',
      error: e,
      stackTrace: stackTrace,
    );
  }

  await Future.wait([
    initDependencies(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);
}
