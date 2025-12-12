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
  container,
}

/// Extension for custom app colors .
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors(this._colors, {this.cardGradient = const []});

  final Map<AppColorKey, Color> _colors;
  final List<Color> cardGradient;

  /// Easy access to colors by key.
  Color operator [](AppColorKey key) => _colors[key]!;

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
  Color get container => this[AppColorKey.container];

  /// Light theme
  static final light = AppColors(
    {
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
      AppColorKey.container: const Color(0xFF111827),
    },
    cardGradient: const [Color(0xFF10B981), Color(0xFF059669)],
  );

  /// Dark theme
  static final dark = AppColors(
    {
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
      AppColorKey.container: const Color(0xFFF9FAFB),
    },
    cardGradient: const [Color(0xFF34D399), Color(0xFF059669)],
  );

  @override
  AppColors copyWith({
    Map<AppColorKey, Color>? colors,
    List<Color>? cardGradient,
  }) {
    return AppColors({
      ..._colors,
      ...?colors,
    }, cardGradient: cardGradient ?? this.cardGradient);
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
      cardGradient: List.generate(
        cardGradient.length,
        (i) => Color.lerp(
          cardGradient[i],
          other.cardGradient.length > i
              ? other.cardGradient[i]
              : cardGradient[i],
          t,
        )!,
      ),
    );
  }
}

/// Extension on BuildContext for easy access to app colors.
extension AppColorsExtension on BuildContext {
  /// Gets the current theme's app colors.
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
