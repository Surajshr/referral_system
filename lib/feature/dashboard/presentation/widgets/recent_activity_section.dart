import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/activity_card.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';

class RecentActivitySection extends StatelessWidget {
  const RecentActivitySection({super.key, required this.transactions});

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    // Show only the 3 most recent transactions
    final recentTransactions = transactions.take(3).toList();

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
              onPressed: () {
                context.push(
                  RouteName.allTransactionsScreen,
                  extra: transactions,
                );
              },
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
        if (recentTransactions.isEmpty)
          _buildEmptyState(context)
        else
          ...recentTransactions.asMap().entries.map(
            (entry) => Padding(
              padding: EdgeInsets.only(
                bottom: entry.key < recentTransactions.length - 1 ? 12.h : 0,
              ),
              child: ActivityCard.fromTransaction(transaction: entry.value),
            ),
          ),
        60.verticalSpace,
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: context.appColors.surface,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: context.appColors.border, width: 1),
      ),
      child: Center(
        child: Column(
          children: [
            Image.asset(
              ImageConstants.emptyWalletIcon,
              width: 64.w,
              height: 64.h,
              color: context.appColors.textMuted,
            ),
            16.verticalSpace,
            BuildText(
              text: 'You have not made any transactions yet',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: context.appColors.text,
            ),
            8.verticalSpace,
            BuildText(
              text:
                  'You can make your first transaction by clicking the button below or by inviting your friends',
              fontSize: 14.sp,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
              height: 1.5,
              color: context.appColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
