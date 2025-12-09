import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/cubit/theme_cubit.dart';

class SignInBaseView extends StatefulWidget {
  const SignInBaseView({super.key});

  @override
  State<SignInBaseView> createState() => _SignInBaseViewState();
}

class _SignInBaseViewState extends State<SignInBaseView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        // lib/feature/auth/signIn/presentation/view/signin_base_view.dart
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              IconData icon;
              String tooltip;

              switch (themeMode) {
                case ThemeMode.light:
                  icon = Icons.light_mode;
                  tooltip = 'Light Mode';
                case ThemeMode.dark:
                  icon = Icons.dark_mode;
                  tooltip = 'Dark Mode';
                case ThemeMode.system:
                  icon = Icons.brightness_auto;
                  tooltip = 'System Mode';
              }

              return IconButton(
                icon: Icon(icon),
                tooltip: tooltip,
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: const Center(child: Text('Sign In')),
    );
  }
}
