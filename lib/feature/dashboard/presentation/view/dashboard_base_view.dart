import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/core/di/di.dart';
import 'package:referral_app/core/services/storage/secure_storage_service.dart';
import 'package:referral_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:referral_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:referral_app/feature/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/dashboard_shimmer.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/first_transaction_prompt.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/how_it_works_section.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/recent_activity_section.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/referral_code_card.dart';
import 'package:referral_app/feature/dashboard/presentation/widgets/referral_statistics_card.dart';
import 'package:referral_app/widgets/app_top_section_widget.dart';

class DashboardBaseScreen extends StatefulWidget {
  const DashboardBaseScreen({super.key});

  @override
  State<DashboardBaseScreen> createState() => _DashboardBaseScreenState();
}

class _DashboardBaseScreenState extends State<DashboardBaseScreen> {
  final SecureStorageService _secureStorage = di<SecureStorageService>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initDashboard();
    });
  }

  Future<void> _initDashboard() async {
    final userId = await _secureStorage.getUserId();
    if (userId != null && mounted) {
      context.read<DashboardBloc>().add(DashboardInitRequested(userId: userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouteName.transactionBaseScreen);
        },
        backgroundColor: context.appColors.primary,
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: Image.asset(ImageConstants.sendMoneyIcon, color: Colors.white),
        ),
      ),
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
            child: BlocBuilder<DashboardBloc, DashboardBlocState>(
              builder: (context, state) {
                return switch (state) {
                  DashboardInitial() ||
                  DashboardLoading() => _buildLoadingState(),
                  DashboardSuccess() => _buildSuccessState(context, state),
                  DashboardFailure() => _buildErrorState(context, state),
                };
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return const DashboardShimmer();
  }

  Widget _buildSuccessState(BuildContext context, DashboardSuccess state) {
    final dashboard = state.dashboardEntity;
    final balance = dashboard.wallet.balance;
    final referralCount = dashboard.successfulReferralCount;
    final referralCode = dashboard.referralCode;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ReferralStatisticsCard(
            totalReferrals: referralCount,
            totalEarnings: '\$${balance.toStringAsFixed(2)}',
          ),
          16.verticalSpace,
          ReferralCodeCard(referralCode: referralCode),
          16.verticalSpace,
          const FirstTransactionPrompt(),
          24.verticalSpace,
          const HowItWorksSection(),
          24.verticalSpace,
          RecentActivitySection(transactions: dashboard.transactionHistory),
          32.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, DashboardFailure state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64.r,
              color: context.appColors.error,
            ),
            16.verticalSpace,
            Text(
              'Failed to load dashboard',
              style: context.textStyles.headline400,
            ),
            8.verticalSpace,
            Text(
              state.exception.message,
              style: context.textStyles.bodyText100,
              textAlign: TextAlign.center,
            ),
            24.verticalSpace,
            ElevatedButton(
              onPressed: _initDashboard,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
