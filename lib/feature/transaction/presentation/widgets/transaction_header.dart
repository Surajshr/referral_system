import 'package:referral_app/app/view/app_imports.dart';

class TransactionHeader extends StatelessWidget {
  const TransactionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: context.appColors.success.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: context.appColors.success.withValues(alpha: 0.4),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.local_offer_rounded,
                  color: context.appColors.success,
                  size: 14.sp,
                ),
                6.horizontalSpace,
                BuildText(
                  text: 'LIMITED OFFER',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: context.appColors.success,
                  letterSpacing: 0.5,
                ),
              ],
            ),
          ),

          16.verticalSpace,

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: AppConstants.kFontFamily,
                      height: 1.2,
                    ),
                    children: [
                      TextSpan(
                        text: 'Unlock your ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextSpan(
                        text: '\$20\n',
                        style: TextStyle(color: context.appColors.success),
                      ),
                      TextSpan(
                        text: 'Bonus',
                        style: TextStyle(color: context.appColors.success),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          12.verticalSpace,

          BuildText(
            text:
                'Complete your first transfer of \$50 or more to activate your referral reward immediately.',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white.withValues(alpha: 0.85),
            maxLines: 3,
            height: 1.5,
          ),
        ],
      ),
    );
  }
}
