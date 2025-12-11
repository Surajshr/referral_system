import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/splash/presentation/cubit/splash_cubit.dart';

class SplashBaseScreen extends StatefulWidget {
  const SplashBaseScreen({super.key});

  @override
  State<SplashBaseScreen> createState() => _SplashBaseScreenState();
}

class _SplashBaseScreenState extends State<SplashBaseScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.read<SplashCubit>().splashNavigationHandler(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset(ImageConstants.appIcon)],
        ),
      ),
    );
  }
}
