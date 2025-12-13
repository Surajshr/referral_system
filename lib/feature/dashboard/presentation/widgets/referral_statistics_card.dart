import 'package:referral_app/app/view/app_imports.dart';

class ReferralStatisticsCard extends StatelessWidget {
  const ReferralStatisticsCard({
    super.key,
    required this.totalReferrals,
    required this.totalEarnings,
  });

  final int totalReferrals;
  final String totalEarnings;

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
            text: 'Referral Statistics',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.appColors.text,
          ),
          20.verticalSpace,
          Row(
            children: [
              Expanded(
                child: _StatisticItem(
                  icon: Icons.people_rounded,
                  label: 'Successful Referrals',
                  value: totalReferrals.toString(),
                  iconColor: context.appColors.primary,
                  iconBackgroundColor: context.appColors.primary.withValues(
                    alpha: 0.1,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: _StatisticItem(
                  icon: Icons.account_balance_wallet_rounded,
                  label: 'Total Earnings',
                  value: totalEarnings,
                  iconColor: const Color(0xFF4CAF50),
                  iconBackgroundColor: const Color(
                    0xFF4CAF50,
                  ).withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatisticItem extends StatelessWidget {
  const _StatisticItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
    required this.iconBackgroundColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final Color iconColor;
  final Color iconBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.appColors.surfaceVariant,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 24.sp),
          ),
          16.verticalSpace,
          BuildText(
            text: value,
            fontSize: 28.sp,
            fontWeight: FontWeight.w700,
            color: context.appColors.text,
          ),
          4.verticalSpace,
          BuildText(
            text: label,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: context.appColors.textSecondary,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
