import 'package:flutter/widgets.dart';
import 'package:referral_app/app/view/app_imports.dart';

class BuildText extends StatelessWidget {
  const BuildText({
    super.key,
    this.text = '',
    this.fontSize,
    this.color,
    this.family = '',
    this.height = 1.1,
    this.letterSpacing,
    this.decoration = TextDecoration.none,
    this.decorationColor,
    this.textAlign = TextAlign.start,
    this.maxLines = 10,
    this.italics = false,
    this.fontWeight = FontWeight.w400,
    this.shadows,
    this.onTextPressed,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final double? fontSize;
  final double height;
  final double? letterSpacing;
  final Color? color;
  final TextDecoration decoration;
  final Color? decorationColor;
  final TextAlign textAlign;
  final int? maxLines;
  final bool italics;
  final String? family;
  final List<Shadow>? shadows;

  final void Function()? onTextPressed;
  final FontWeight? fontWeight;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTextPressed,
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: family ?? AppConstants.kFontFamily,
          letterSpacing: letterSpacing,
          height: height,
          color: color ?? context.appColors.text,
          decoration: decoration,
          decorationColor: decorationColor,
          fontWeight: fontWeight,
          shadows: shadows,
        ),
      ),
    );
  }
}
