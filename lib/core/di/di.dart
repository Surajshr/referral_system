import 'package:get_it/get_it.dart';

final GetIt di = GetIt.instance;

Future<void> initDependencies() async {
  await _initCriticalDependencies();
  _initNonCriticalDependencies();
}

Future<void> _initCriticalDependencies() async {
  // Initialize Google Sign-In after registration
  // await oAuthService.initGoogleSignIn();
}

void _initNonCriticalDependencies() {
  // Register external services here
  // Example: Analytics, Crash reporting, etc.
}

void reset() {
  di.reset();
}
