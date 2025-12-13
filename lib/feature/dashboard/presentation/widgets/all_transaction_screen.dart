import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/activity_card.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';
import 'package:referral_app/widgets/app_top_section_widget.dart';

class AllTransactionScreen extends StatelessWidget {
  const AllTransactionScreen({super.key, required this.transactions});

  final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                60.verticalSpace,
                const AppTopSectionWidget(
                  showBackButton: true,
                  title: 'All Transactions',
                ),
                16.verticalSpace,
              ],
            ),
          ),
          Expanded(
            child: transactions.isEmpty
                ? _buildEmptyState(context)
                : ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 8.h,
                    ),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: index < transactions.length - 1 ? 12.h : 0,
                        ),
                        child: ActivityCard.fromTransaction(
                          transaction: transactions[index],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 64.r,
              color: context.appColors.textMuted,
            ),
            16.verticalSpace,
            BuildText(
              text: 'No transactions yet',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: context.appColors.text,
            ),
            8.verticalSpace,
            BuildText(
              text: 'Your transaction history will appear here',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: context.appColors.textSecondary,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
