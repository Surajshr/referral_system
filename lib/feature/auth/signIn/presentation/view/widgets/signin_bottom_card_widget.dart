import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/auth/signIn/presentation/view/widgets/referral_info_card_widget.dart';

class SignInBottomCardWidget extends StatelessWidget {
  const SignInBottomCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: context.appColors.border,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          BuildText(
            text: 'Why Join Our Referral Program?',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
          18.verticalSpace,
          ReferralInforCardWidget(
            title: 'Earn Rewards',
            description: 'Get \$10 for every friend you refer',
            image: ImageConstants.dollarIcon,
            iconColor: context.appColors.container,
          ),
          16.verticalSpace,
          ReferralInforCardWidget(
            title: 'Track Progress',
            description: 'Monitor your referrals in real-time',
            image: ImageConstants.barChartIcon,
            iconColor: context.appColors.container,
          ),
          16.verticalSpace,
          ReferralInforCardWidget(
            title: 'Unlock Bonuses',
            description: 'Reach milestones for extra rewards',
            image: ImageConstants.trophyIcon,
            iconColor: context.appColors.container,
          ),
        ],
      ),
    );
  }
}
