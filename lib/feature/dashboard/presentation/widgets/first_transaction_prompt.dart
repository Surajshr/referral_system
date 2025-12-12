import 'package:referral_app/app/view/app_imports.dart';

class FirstTransactionPrompt extends StatelessWidget {
  const FirstTransactionPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(RouteName.transactionBaseScreen),
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          color: context.appColors.primary.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(
            color: context.appColors.primary.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: context.appColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Image.asset(
                ImageConstants.giftBoxIcon,
                width: 32.w,
                height: 32.h,
                color: context.appColors.primary,
              ),
            ),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildText(
                    text: 'Earn \$20 Bonus!',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: context.appColors.text,
                  ),
                  4.verticalSpace,
                  BuildText(
                    text: 'Complete your first transaction and get rewarded',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: context.appColors.textSecondary,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: context.appColors.primary),
          ],
        ),
      ),
    );
  }
}
