import 'dart:async';

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
  // Initialize Supabase first
  await SupabaseService.initialize(
    url: EnvironmentConstants.supabaseUrl,
    anonKey: EnvironmentConstants.supabaseAnonKey,
  );

  await Future.wait([
    initDependencies(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);
}
