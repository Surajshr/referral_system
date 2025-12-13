import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/core/route/route_imports.dart';

// ignore: inference_failure_on_function_return_type
showLoadingDialog() {
  showGeneralDialog(
    context: navigatorKey.currentContext!,
    barrierDismissible: false,
    pageBuilder: (_, __, ___) {
      return Material(
        color: Colors.grey.withValues(alpha: 0.4),
        child: const SizedBox(
          height: 150,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    },
  );
}

hideLoadingDialog() {
  Navigator.of(navigatorKey.currentContext!).pop();
}
