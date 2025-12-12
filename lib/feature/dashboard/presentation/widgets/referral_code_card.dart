import 'package:flutter/services.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/widgets/app_snackbar.dart';
import 'package:share_plus/share_plus.dart';

class ReferralCodeCard extends StatelessWidget {
  const ReferralCodeCard({super.key, required this.referralCode});

  final String referralCode;

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: referralCode));
    AppSnackbar.showSuccess(context, 'Referral code copied!');
  }

  void _shareCode() {
    Share.share(
      'Join me on this amazing app! Use my referral code: $referralCode to get \$20 bonus on your first transaction.',
      subject: 'Join and Earn \$20!',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: context.appColors.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: context.appColors.shadow.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildText(
            text: 'Your Referral Code',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.appColors.text,
          ),
          16.verticalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              color: context.appColors.surfaceVariant,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: context.appColors.primary.withValues(alpha: 0.3),
                width: 2,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildText(
                  text: referralCode,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: context.appColors.primary,
                  letterSpacing: 2,
                ),
                GestureDetector(
                  onTap: () => _copyToClipboard(context),
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: context.appColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.copy_rounded,
                      color: context.appColors.primary,
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpace,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _shareCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.appColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
              icon: Icon(Icons.share_rounded, size: 20.sp),
              label: BuildText(
                text: 'Share Code',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
