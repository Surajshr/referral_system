import 'package:lottie/lottie.dart';
import 'package:referral_app/app/view/app_imports.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key, this.opacity = 0.1});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Material(
      color: context.appColors.container.withValues(alpha: opacity),
      child: Center(
        child: Lottie.asset(
          isDarkMode
              ? ImageConstants.whiteLoaderLottie
              : ImageConstants.loaderLottie,
          width: 180.h,
          height: 180.h,
        ),
      ),
    );
  }
}
