import 'package:referral_app/app/view/app_imports.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    super.key,
    this.elevation,
    this.onPressed,
    this.buttonColor,
    this.width,
    this.height,
    this.textStyle,
    this.isLoading = false,
    this.textAlign,
    this.borderRadius,
    this.buttonBorderColor,
  });

  final double? elevation;
  final Color? buttonColor;
  final Color? buttonBorderColor;
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48.h,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(elevation ?? 0),
          backgroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (!states.contains(WidgetState.disabled)) {
              return buttonColor ?? context.appColors.primary;
            }
            return null; // Defer to the widget's default.
          }),
          foregroundColor: WidgetStateProperty.resolveWith<Color?>((
            Set<WidgetState> states,
          ) {
            if (states.contains(WidgetState.disabled)) return Colors.white;
            return null; // Defer to the widget's default.
          }),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 32.r),
              side: buttonBorderColor != null
                  ? BorderSide(color: buttonBorderColor!)
                  : BorderSide.none,
            ),
          ),
        ),
        onPressed: onPressed,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: context.appColors.background,
                ),
              )
            : Text(
                text,
                style:
                    textStyle ??
                    context.textStyles.bodyText200.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.surface,
                    ),
                textAlign: textAlign ?? TextAlign.center,
              ),
      ),
    );
  }
}
