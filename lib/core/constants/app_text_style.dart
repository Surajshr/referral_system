import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:referral_app/core/constants/app_color.dart';
import 'package:referral_app/core/constants/app_constants.dart';

@immutable
class AppTextStyles extends ThemeExtension<AppTextStyles> {
  const AppTextStyles({
    required this.headline700,
    required this.headline600,
    required this.headline400,
    required this.headline300,
    required this.headline200,
    required this.bodyText200,
    required this.bodyText100,
    required this.bodyText10,
    required this.textlgMedium,
  });

  final TextStyle headline700;
  final TextStyle headline600;
  final TextStyle headline400;
  final TextStyle headline300;
  final TextStyle headline200;
  final TextStyle bodyText200;
  final TextStyle bodyText100;
  final TextStyle bodyText10;
  final TextStyle textlgMedium;

  /// Creates text styles for the given theme colors.
  factory AppTextStyles.fromColors(AppColors colors) {
    return AppTextStyles(
      headline700: TextStyle(
        letterSpacing: 0.3.sp,
        fontSize: 30.sp,
        height: 45.sp / 30.sp,
        fontWeight: FontWeight.w700,
        color: colors.text,
        fontFamily: AppConstants.kFontFamily,
      ),
      headline600: TextStyle(
        letterSpacing: 0.3.sp,
        fontSize: 20.sp,
        height: 30.sp / 20.sp,
        fontWeight: FontWeight.w600,
        color: colors.text,
        fontFamily: AppConstants.kFontFamily,
      ),
      headline400: TextStyle(
        letterSpacing: 0.3.sp,
        fontSize: 16.sp,
        height: 26.sp / 16.sp,
        fontWeight: FontWeight.w600,
        color: colors.text,
        fontFamily: AppConstants.kFontFamily,
      ),
      headline300: TextStyle(
        letterSpacing: 0.3.sp,
        fontSize: 14.sp,
        height: 16.8.sp / 14.sp,
        fontWeight: FontWeight.w700,
        color: colors.text,
        fontFamily: AppConstants.kFontFamily,
      ),
      headline200: TextStyle(
        letterSpacing: 1.sp,
        fontSize: 12.sp,
        height: 22.sp / 12.sp,
        color: colors.text,
        fontWeight: FontWeight.w700,
        fontFamily: AppConstants.kFontFamily,
      ),
      bodyText200: TextStyle(
        letterSpacing: 0.3.sp,
        fontSize: 14.sp,
        height: 24.sp / 14.sp,
        fontWeight: FontWeight.w400,
        color: colors.textSecondary,
        fontFamily: AppConstants.kFontFamily,
      ),
      bodyText100: TextStyle(
        letterSpacing: 0.3.sp,
        fontSize: 12.sp,
        height: 22.sp / 12.sp,
        fontWeight: FontWeight.w400,
        color: colors.textSecondary,
        fontFamily: AppConstants.kFontFamily,
      ),
      bodyText10: TextStyle(
        letterSpacing: 0.3.sp,
        fontSize: 11.sp,
        height: 13.3.sp / 11.sp,
        fontWeight: FontWeight.w400,
        color: colors.textMuted,
        fontFamily: AppConstants.kFontFamily,
      ),
      textlgMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: colors.text,
        fontFamily: AppConstants.kFontFamily,
      ),
    );
  }

  @override
  AppTextStyles copyWith({
    TextStyle? headline700,
    TextStyle? headline600,
    TextStyle? headline400,
    TextStyle? headline300,
    TextStyle? headline200,
    TextStyle? bodyText200,
    TextStyle? bodyText100,
    TextStyle? bodyText10,
    TextStyle? textlgMedium,
  }) {
    return AppTextStyles(
      headline700: headline700 ?? this.headline700,
      headline600: headline600 ?? this.headline600,
      headline400: headline400 ?? this.headline400,
      headline300: headline300 ?? this.headline300,
      headline200: headline200 ?? this.headline200,
      bodyText200: bodyText200 ?? this.bodyText200,
      bodyText100: bodyText100 ?? this.bodyText100,
      bodyText10: bodyText10 ?? this.bodyText10,
      textlgMedium: textlgMedium ?? this.textlgMedium,
    );
  }

  @override
  AppTextStyles lerp(ThemeExtension<AppTextStyles>? other, double t) {
    if (other is! AppTextStyles) return this;
    return AppTextStyles(
      headline700: TextStyle.lerp(headline700, other.headline700, t)!,
      headline600: TextStyle.lerp(headline600, other.headline600, t)!,
      headline400: TextStyle.lerp(headline400, other.headline400, t)!,
      headline300: TextStyle.lerp(headline300, other.headline300, t)!,
      headline200: TextStyle.lerp(headline200, other.headline200, t)!,
      bodyText200: TextStyle.lerp(bodyText200, other.bodyText200, t)!,
      bodyText100: TextStyle.lerp(bodyText100, other.bodyText100, t)!,
      bodyText10: TextStyle.lerp(bodyText10, other.bodyText10, t)!,
      textlgMedium: TextStyle.lerp(textlgMedium, other.textlgMedium, t)!,
    );
  }
}

/// Extension on BuildContext for easy access to app text styles.
extension AppTextStylesExtension on BuildContext {
  /// Gets the current theme's text styles.
  AppTextStyles get textStyles => Theme.of(this).extension<AppTextStyles>()!;
}
