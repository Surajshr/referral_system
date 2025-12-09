import 'package:flutter/material.dart';

/// Color keys for the app theme.
enum AppColorKey {
  primary,
  background,
  surface,
  surfaceVariant,
  text,
  textSecondary,
  textMuted,
  border,
  divider,
  error,
  success,
  warning,
  buttonBackground,
  buttonText,
  checkBox,
  radioButton,
  otpSendButton,
  screenLockContainer,
  glassmorphismBackground,
  cardBackground,
  shadow,
  inputFill,
  inputBorder,
  inputFocusedBorder,
}

/// Extension for custom app colors with easy maintenance.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors(this._colors);

  final Map<AppColorKey, Color> _colors;

  /// Easy access to colors by key.
  Color operator [](AppColorKey key) => _colors[key]!;

  // Convenient getters for autocomplete support
  Color get primary => this[AppColorKey.primary];
  Color get background => this[AppColorKey.background];
  Color get surface => this[AppColorKey.surface];
  Color get surfaceVariant => this[AppColorKey.surfaceVariant];
  Color get text => this[AppColorKey.text];
  Color get textSecondary => this[AppColorKey.textSecondary];
  Color get textMuted => this[AppColorKey.textMuted];
  Color get border => this[AppColorKey.border];
  Color get divider => this[AppColorKey.divider];
  Color get error => this[AppColorKey.error];
  Color get success => this[AppColorKey.success];
  Color get warning => this[AppColorKey.warning];
  Color get buttonBackground => this[AppColorKey.buttonBackground];
  Color get buttonText => this[AppColorKey.buttonText];
  Color get checkBox => this[AppColorKey.checkBox];
  Color get radioButton => this[AppColorKey.radioButton];
  Color get otpSendButton => this[AppColorKey.otpSendButton];
  Color get screenLockContainer => this[AppColorKey.screenLockContainer];
  Color get glassmorphismBackground =>
      this[AppColorKey.glassmorphismBackground];
  Color get cardBackground => this[AppColorKey.cardBackground];
  Color get shadow => this[AppColorKey.shadow];
  Color get inputFill => this[AppColorKey.inputFill];
  Color get inputBorder => this[AppColorKey.inputBorder];
  Color get inputFocusedBorder => this[AppColorKey.inputFocusedBorder];

  /// Light theme - Clean, professional, modern palette.
  static final light = AppColors({
    AppColorKey.primary: const Color(0xFF10B981),
    AppColorKey.background: const Color(0xFFFAFAFA),
    AppColorKey.surface: const Color(0xFFFFFFFF),
    AppColorKey.surfaceVariant: const Color(0xFFF5F5F5),
    AppColorKey.text: const Color(0xFF111827),
    AppColorKey.textSecondary: const Color(0xFF6B7280),
    AppColorKey.textMuted: const Color(0xFF9CA3AF),
    AppColorKey.border: const Color(0xFFE5E7EB),
    AppColorKey.divider: const Color(0xFFF3F4F6),
    AppColorKey.error: const Color(0xFFEF4444),
    AppColorKey.success: const Color(0xFF10B981),
    AppColorKey.warning: const Color(0xFFF59E0B),
    AppColorKey.buttonBackground: const Color(0xFF059669),
    AppColorKey.buttonText: const Color(0xFFFFFFFF),
    AppColorKey.checkBox: const Color(0xFF10B981),
    AppColorKey.radioButton: const Color(0xFF10B981),
    AppColorKey.otpSendButton: const Color(0xFF0891B2),
    AppColorKey.screenLockContainer: const Color(0xFF06B6D4),
    AppColorKey.glassmorphismBackground: const Color(0x1A000000),
    AppColorKey.cardBackground: const Color(0xFFFFFFFF),
    AppColorKey.shadow: const Color(0x0D000000),
    AppColorKey.inputFill: const Color(0xFFFAFAFA),
    AppColorKey.inputBorder: const Color(0xFFD1D5DB),
    AppColorKey.inputFocusedBorder: const Color(0xFF10B981),
  });

  /// Dark theme - Easy on eyes, excellent contrast, modern feel.
  static final dark = AppColors({
    AppColorKey.primary: const Color(0xFF34D399),
    AppColorKey.background: const Color(0xFF0A0A0B),
    AppColorKey.surface: const Color(0xFF1C1C1E),
    AppColorKey.surfaceVariant: const Color(0xFF2C2C2E),
    AppColorKey.text: const Color(0xFFF9FAFB),
    AppColorKey.textSecondary: const Color(0xFFD1D5DB),
    AppColorKey.textMuted: const Color(0xFF9CA3AF),
    AppColorKey.border: const Color(0xFF374151),
    AppColorKey.divider: const Color(0xFF1F2937),
    AppColorKey.error: const Color(0xFFF87171),
    AppColorKey.success: const Color(0xFF34D399),
    AppColorKey.warning: const Color(0xFFFBBF24),
    AppColorKey.buttonBackground: const Color(0xFF059669),
    AppColorKey.buttonText: const Color(0xFFFFFFFF),
    AppColorKey.checkBox: const Color(0xFF34D399),
    AppColorKey.radioButton: const Color(0xFF34D399),
    AppColorKey.otpSendButton: const Color(0xFF06B6D4),
    AppColorKey.screenLockContainer: const Color(0xFF0891B2),
    AppColorKey.glassmorphismBackground: const Color(0x4D000000),
    AppColorKey.cardBackground: const Color(0xFF1C1C1E),
    AppColorKey.shadow: const Color(0x66000000),
    AppColorKey.inputFill: const Color(0xFF1C1C1E),
    AppColorKey.inputBorder: const Color(0xFF374151),
    AppColorKey.inputFocusedBorder: const Color(0xFF34D399),
  });

  @override
  AppColors copyWith({Map<AppColorKey, Color>? colors}) {
    return AppColors({..._colors, ...?colors});
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      Map.fromEntries(
        _colors.keys.map(
          (key) =>
              MapEntry(key, Color.lerp(_colors[key], other._colors[key], t)!),
        ),
      ),
    );
  }
}

/// Theme palette configuration for different visual themes (1-5).
@immutable
class ThemePalette {
  const ThemePalette({
    required this.buttonColor,
    required this.radioButtonColor,
    required this.backgroundColor,
  });

  final Color buttonColor;
  final Color radioButtonColor;
  final Color backgroundColor;

  /// Copy with pattern for easy modifications.
  ThemePalette copyWith({
    Color? buttonColor,
    Color? radioButtonColor,
    Color? backgroundColor,
  }) {
    return ThemePalette(
      buttonColor: buttonColor ?? this.buttonColor,
      radioButtonColor: radioButtonColor ?? this.radioButtonColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

/// Available theme palettes for both light and dark modes.
class AppThemePalettes {
  AppThemePalettes._();

  // Light mode palettes - Carefully curated color harmonies.
  static const lightPalettes = <int, ThemePalette>{
    1: ThemePalette(
      buttonColor: Color(0xFF059669),
      radioButtonColor: Color(0xFF10B981),
      backgroundColor: Color(0xFFD1FAE5),
    ),
    2: ThemePalette(
      buttonColor: Color(0xFF0284C7),
      radioButtonColor: Color(0xFF0EA5E9),
      backgroundColor: Color(0xFFBAE6FD),
    ),
    3: ThemePalette(
      buttonColor: Color(0xFF7C3AED),
      radioButtonColor: Color(0xFF8B5CF6),
      backgroundColor: Color(0xFFDDD6FE),
    ),
    4: ThemePalette(
      buttonColor: Color(0xFFEA580C),
      radioButtonColor: Color(0xFFF97316),
      backgroundColor: Color(0xFFFFEDD5),
    ),
    5: ThemePalette(
      buttonColor: Color(0xFFE11D48),
      radioButtonColor: Color(0xFFF43F5E),
      backgroundColor: Color(0xFFFFE4E6),
    ),
  };

  // Dark mode palettes - Vibrant yet easy on eyes, excellent contrast.
  static const darkPalettes = <int, ThemePalette>{
    1: ThemePalette(
      buttonColor: Color(0xFF10B981),
      radioButtonColor: Color(0xFF34D399),
      backgroundColor: Color(0xFF064E3B),
    ),
    2: ThemePalette(
      buttonColor: Color(0xFF0EA5E9),
      radioButtonColor: Color(0xFF38BDF8),
      backgroundColor: Color(0xFF075985),
    ),
    3: ThemePalette(
      buttonColor: Color(0xFF8B5CF6),
      radioButtonColor: Color(0xFFA78BFA),
      backgroundColor: Color(0xFF5B21B6),
    ),
    4: ThemePalette(
      buttonColor: Color(0xFFF97316),
      radioButtonColor: Color(0xFFFB923C),
      backgroundColor: Color(0xFF9A3412),
    ),
    5: ThemePalette(
      buttonColor: Color(0xFFF43F5E),
      radioButtonColor: Color(0xFFFB7185),
      backgroundColor: Color(0xFF9F1239),
    ),
  };

  /// Gets the theme palette for the given theme ID and brightness.
  static ThemePalette getPalette(int themeId, Brightness brightness) {
    final palettes = brightness == Brightness.light
        ? lightPalettes
        : darkPalettes;
    return palettes[themeId] ?? palettes[1]!;
  }

  /// Gets button color for a theme ID and brightness.
  static Color getButtonColor(int themeId, Brightness brightness) {
    return getPalette(themeId, brightness).buttonColor;
  }

  /// Gets radio button color for a theme ID and brightness.
  static Color getRadioButtonColor(int themeId, Brightness brightness) {
    return getPalette(themeId, brightness).radioButtonColor;
  }

  /// Gets background color for a theme ID and brightness.
  static Color getBackgroundColor(int themeId, Brightness brightness) {
    return getPalette(themeId, brightness).backgroundColor;
  }
}

/// Extension on BuildContext for easy access to app colors.
extension AppColorsExtension on BuildContext {
  /// Gets the current theme's app colors.
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;

  /// Gets a theme palette for the given ID based on current brightness.
  ThemePalette themePalette(int themeId) {
    final brightness = Theme.of(this).brightness;
    return AppThemePalettes.getPalette(themeId, brightness);
  }
}
