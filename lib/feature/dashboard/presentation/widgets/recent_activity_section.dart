import 'package:referral_app/app/view/app_imports.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BuildText(
              text: 'Recent Activity',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: context.appColors.text,
            ),
            TextButton(
              onPressed: () {},
              child: BuildText(
                text: 'View All',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: context.appColors.primary,
              ),
            ),
          ],
        ),
        12.verticalSpace,
        _ActivityCard(
          icon: ImageConstants.trophyIcon,
          title: 'Referral Bonus',
          subtitle: 'From John Doe',
          time: '2 hours ago',
          amount: '+\$20',
          isPositive: true,
        ),
        12.verticalSpace,
        _ActivityCard(
          icon: ImageConstants.transactionIcon,
          title: 'First Transaction',
          subtitle: 'Completed',
          time: '1 day ago',
          amount: '+\$20',
          isPositive: true,
        ),
        12.verticalSpace,
        _ActivityCard(
          icon: ImageConstants.piggyBankIcon,
          title: 'Referral Pending',
          subtitle: 'Jane Smith',
          time: '2 days ago',
          amount: 'Pending',
          isPositive: false,
        ),
      ],
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.amount,
    required this.isPositive,
  });

  final String icon;
  final String title;
  final String subtitle;
  final String time;
  final String amount;
  final bool isPositive;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            width: 48.w,
            height: 48.h,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: isPositive
                  ? context.appColors.success.withValues(alpha: 0.1)
                  : context.appColors.warning.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              icon,
              color: isPositive
                  ? context.appColors.success
                  : context.appColors.warning,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildText(
                  text: title,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: context.appColors.text,
                ),
                4.verticalSpace,
                Row(
                  children: [
                    BuildText(
                      text: subtitle,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.textSecondary,
                    ),
                    BuildText(
                      text: ' • ',
                      fontSize: 13.sp,
                      color: context.appColors.textMuted,
                    ),
                    BuildText(
                      text: time,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.textMuted,
                    ),
                  ],
                ),
              ],
            ),
          ),
          BuildText(
            text: amount,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: isPositive
                ? context.appColors.success
                : context.appColors.warning,
          ),
        ],
      ),
    );
  }
}
