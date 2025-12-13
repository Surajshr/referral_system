import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/cubit/theme_cubit.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/app/view/app_providers.dart';
import 'package:referral_app/core/constants/environment_constants.dart';
import 'package:referral_app/core/route/route_imports.dart';

class App extends StatelessWidget {
  const App({super.key, required this.environment});
  final Environment environment;

  @override
  Widget build(BuildContext context) {
    return AppProviders(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            ScreenUtilInit(
              designSize: const Size(
                AppConstants.kAppWidth,
                AppConstants.kAppHeight,
              ),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return MaterialApp.router(
                      routerConfig: router,
                      theme: _buildTheme(Brightness.light),
                      darkTheme: _buildTheme(Brightness.dark),
                      themeMode: themeMode,
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      supportedLocales: AppLocalizations.supportedLocales,
                    );
                  },
                );
              },
            ),

            if (environment == Environment.dev ||
                environment == Environment.stag)
              Banner(
                message: environment.name.toUpperCase(),
                location: BannerLocation.topEnd,
                color: environment == Environment.dev
                    ? Colors.red
                    : Colors.blue,
              ),
          ],
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
