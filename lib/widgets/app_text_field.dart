import 'package:referral_app/app/view/app_imports.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.onChanged,
    this.labelText,
    this.errorText,
    this.suffixIcon,
    this.keyBoardType,
    this.borderColor,
    this.obscureText = false,
    this.minLines = 1,
    this.labelTextStyle,
    this.focusNode,
    this.prefixIcon,
    this.onSubmitted,
    this.readOnly,
    this.onTap,
    this.fillColor,
    this.scrollController,
    this.hintText,
    this.hintTextStyle,
    this.maxLength,
    this.textCapitalization,
    this.validator,
    this.textInputAction,
    this.maxLines,
    this.height,
    this.showCounter = false,
    this.shouldShowErrorText = true,
    this.titleText,
    this.autoFocus = false,
  });

  final TextEditingController? controller;
  final ScrollController? scrollController;
  final bool obscureText;
  final Function(String latestString)? onChanged;
  final String? labelText;
  final String? errorText;
  final String? hintText;
  final Widget? suffixIcon;

  final TextInputType? keyBoardType;
  final TextStyle? labelTextStyle;
  final TextStyle? hintTextStyle;
  final Color? borderColor;
  final int minLines;
  final int? maxLines;
  final int? maxLength;
  final TextCapitalization? textCapitalization;
  final FocusNode? focusNode;
  final Function(dynamic value)? onSubmitted;
  final Function()? onTap;
  final bool? readOnly;
  final Widget? prefixIcon;
  final Color? fillColor;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final double? height;
  final bool showCounter;
  final bool shouldShowErrorText;
  final String? titleText;
  final bool autoFocus;
  @override
  Widget build(BuildContext context) {
    final effectiveMaxLines = maxLines ?? minLines;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (titleText != null)
                BuildText(
                  text: titleText!,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              10.verticalSpace,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      autofocus: autoFocus ?? false,
                      textCapitalization:
                          textCapitalization ?? TextCapitalization.none,
                      maxLength: maxLength,
                      cursorColor: context.appColors.primary,
                      scrollController: scrollController,
                      onTap: onTap,
                      controller: controller,
                      keyboardType: keyBoardType,
                      obscureText: obscureText,
                      onChanged: onChanged,
                      obscuringCharacter: '*',
                      readOnly: readOnly ?? false,
                      minLines: minLines,
                      maxLines: effectiveMaxLines,
                      focusNode: focusNode,
                      onFieldSubmitted: onSubmitted,
                      textInputAction: textInputAction ?? TextInputAction.next,
                      style: TextStyle(
                        color: context.appColors.text,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle:
                            hintTextStyle ??
                            TextStyle(
                              color: context.appColors.textSecondary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                        labelText: labelText,
                        labelStyle: TextStyle(
                          fontFamily: AppConstants.kFontFamily,
                          color: context.appColors.textSecondary,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.6,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        fillColor: fillColor,
                        filled: fillColor != null,
                        prefixIcon: prefixIcon,
                        contentPadding: EdgeInsets.only(
                          top: 12.h,
                          bottom: 12.h,
                          left: 8.w,
                          right: 8.w,
                        ),
                        suffixIcon: suffixIcon,
                        errorText: errorText != null && shouldShowErrorText
                            ? ''
                            : null,
                        errorStyle: const TextStyle(height: 0, fontSize: 0),

                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        counterText: showCounter ? null : '',
                      ),
                      validator: validator,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (errorText != null && shouldShowErrorText)
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 4.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                errorText!,
                style: TextStyle(
                  fontFamily: AppConstants.kFontFamily,
                  color: Colors.red,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
