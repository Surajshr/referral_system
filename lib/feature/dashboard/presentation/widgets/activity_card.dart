import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.amount,
    required this.isPositive,
  });

  factory ActivityCard.fromTransaction({
    required TransactionModel transaction,
  }) {
    final (icon, title, subtitle, isPositive) = _getTransactionDetails(
      transaction.type,
    );
    final formattedAmount = _formatAmount(transaction.amount, isPositive);
    final formattedTime = _formatRelativeTime(transaction.createdAt);

    return ActivityCard(
      icon: icon,
      title: title,
      subtitle: subtitle,
      time: formattedTime,
      amount: formattedAmount,
      isPositive: isPositive,
    );
  }

  final String icon;
  final String title;
  final String subtitle;
  final String time;
  final String amount;
  final bool isPositive;

  static (String icon, String title, String subtitle, bool isPositive)
  _getTransactionDetails(TransactionType type) {
    return switch (type) {
      TransactionType.referralReward => (
        ImageConstants.trophyIcon,
        'Referral Bonus',
        'Reward earned',
        true,
      ),
      TransactionType.firstTransactionReward => (
        ImageConstants.giftBoxIcon,
        'First Transaction',
        'Bonus earned',
        true,
      ),
      TransactionType.withdrawal => (
        ImageConstants.transactionIcon,
        'Withdrawal',
        'Money sent',
        false,
      ),
      TransactionType.refund => (
        ImageConstants.piggyBankIcon,
        'Refund',
        'Money refunded',
        true,
      ),
      TransactionType.transaction => (
        ImageConstants.transactionIcon,
        'Transaction',
        'Money transferred',
        true,
      ),
    };
  }

  static String _formatAmount(double amount, bool isPositive) {
    final formatted = '\$${amount.toStringAsFixed(2)}';
    return isPositive ? '+$formatted' : '-$formatted';
  }

  static String _formatRelativeTime(DateTime dateTime) {
    final now = DateTime.now().toLocal();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

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
              cacheWidth: (48.w * 3).toInt(),
              cacheHeight: (48.h * 3).toInt(),
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
