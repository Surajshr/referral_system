import 'package:referral_app/app/view/app_imports.dart';

class ReferralInforCardWidget extends StatelessWidget {
  const ReferralInforCardWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    this.color,
    this.iconColor,
  });

  final String title;
  final String description;
  final String image;
  final Color? color;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: color ?? context.appColors.surface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Image.asset(
            image,
            width: 26.w,
            height: 26.h,
            color: iconColor,
          ),
        ),
        12.horizontalSpace,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BuildText(
              text: title,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
            8.verticalSpace,
            BuildText(
              text: description,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: context.appColors.textSecondary,
            ),
          ],
        ),
      ],
    );
  }
}
