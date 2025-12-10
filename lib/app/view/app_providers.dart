import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/cubit/theme_cubit.dart';
import 'package:referral_app/app/view/app_imports.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        // Core providers that are needed immediately
      ],
      child: child,
    );
  }
}
