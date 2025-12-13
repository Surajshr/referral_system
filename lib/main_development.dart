import 'package:referral_app/app/view/app.dart';
import 'package:referral_app/bootstrap.dart';
import 'package:referral_app/core/constants/environment_constants.dart';
import 'package:referral_app/start_up.dart';

Future<void> main() async {
  EnvironmentConstants.setEnvVariables(Environment.dev);
  await initializeApp();

  await bootstrap(() => const App(environment: Environment.dev));
}
