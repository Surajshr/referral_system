import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/cubit/theme_cubit.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/auth/signIn/presentation/view/signin_base_view.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: ScreenUtilInit(
          designSize: const Size(
            AppConstants.kAppWidth,
            AppConstants.kAppHeight,
          ),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return MaterialApp(
                  theme: _buildTheme(Brightness.light),
                  darkTheme: _buildTheme(Brightness.dark),
                  themeMode: themeMode,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  supportedLocales: AppLocalizations.supportedLocales,
                  home: const SignInBaseView(),
                );
              },
            );
          },
        ),
      ),
    );
  }

  ThemeData _buildTheme(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    final appColors = isDark ? AppColors.dark : AppColors.light;

    final colorScheme = ColorScheme.fromSeed(
      seedColor: appColors.primary,
      brightness: brightness,
      surface: appColors.surface,
      error: appColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: appColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.surface,
        foregroundColor: appColors.text,
        elevation: 0,
      ),
      cardTheme: CardThemeData(
        color: appColors.cardBackground,
        elevation: 2,
        shadowColor: appColors.shadow,
      ),
      dividerTheme: DividerThemeData(color: appColors.divider),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appColors.inputFill,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: appColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: appColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: appColors.inputFocusedBorder, width: 2),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.buttonBackground,
          foregroundColor: appColors.buttonText,
          elevation: 2,
          shadowColor: appColors.shadow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appColors.checkBox;
          }
          return appColors.surface;
        }),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appColors.radioButton;
          }
          return appColors.textMuted;
        }),
      ),
      extensions: [appColors, AppTextStyles.fromColors(appColors)],
    );
  }
}
