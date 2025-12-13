import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/first_transaction_prompt.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/how_it_works_section.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/recent_activity_section.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/referral_code_card.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/total_earnings_card.dart';
import 'package:referral_app/widgets/app_top_section_widget.dart';

class DashboardBaseScreen extends StatefulWidget {
  const DashboardBaseScreen({super.key});

  @override
  State<DashboardBaseScreen> createState() => _DashboardBaseScreenState();
}

class _DashboardBaseScreenState extends State<DashboardBaseScreen> {
  final String referralCode = 'REF2024XYZ';
  final String totalEarnings = '\$100';

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
                AppTopSectionWidget(
                  showBackButton: false,
                  prefix: GestureDetector(
                    onTap: () {
                      context.push(RouteName.profileBaseScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: context.appColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(360.r),
                      ),
                      child: const Icon(Icons.person),
                    ),
                  ),
                  title: 'Refer & Earn',
                ),
                16.verticalSpace,
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total Earnings Card
                  TotalEarningsCard(amount: totalEarnings),
                  16.verticalSpace,

                  // Referral Code Card
                  ReferralCodeCard(referralCode: referralCode),
                  16.verticalSpace,

                  // First Transaction Prompt
                  const FirstTransactionPrompt(),
                  24.verticalSpace,

                  // How It Works Section
                  const HowItWorksSection(),
                  24.verticalSpace,

                  // Recent Activity
                  const RecentActivitySection(),
                  32.verticalSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
