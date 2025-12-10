import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'package:flutter/services.dart';
import 'package:referral_app/core/di/di.dart';

Future<void> initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initializeServices();
}

Future<void> _initializeServices() async {
  await Future.wait([
    initDependencies(),
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
  ]);
}
