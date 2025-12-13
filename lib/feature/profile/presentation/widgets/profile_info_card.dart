import 'package:referral_app/app/view/app_imports.dart';

class ProfileInfoCard extends StatelessWidget {
  const ProfileInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.showArrow = true,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final bool showArrow;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: context.appColors.border, width: 1),
          boxShadow: [
            BoxShadow(
              color: context.appColors.shadow.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, color: context.appColors.primary, size: 20.sp),
            ),

            16.horizontalSpace,

            // Label and Value
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildText(
                    text: label,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.textMuted,
                  ),
                  4.verticalSpace,
                  BuildText(
                    text: value,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: context.appColors.text,
                  ),
                ],
              ),
            ),

            if (showArrow)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: context.appColors.textMuted,
                size: 16.sp,
              ),
          ],
        ),
      ),
    );
  }
}
