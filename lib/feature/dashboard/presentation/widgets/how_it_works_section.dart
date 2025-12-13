import 'package:referral_app/app/view/app_imports.dart';

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildText(
            text: 'How Referral Works',
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: context.appColors.text,
          ),
          4.verticalSpace,
          BuildText(
            text: 'Earn rewards in 3 simple steps',
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: context.appColors.textSecondary,
          ),
          20.verticalSpace,
          const _HowItWorksStep(
            stepNumber: 1,
            icon: Icons.share_rounded,
            title: 'Share your unique code',
            description:
                'Send your code to friends via message, email, or social media',
            isLast: false,
          ),
          const _HowItWorksStep(
            stepNumber: 2,
            icon: Icons.person_add_rounded,
            title: 'Friend signs up',
            description:
                'They enter your code during their registration process',
            isLast: false,
          ),
          const _HowItWorksStep(
            stepNumber: 3,
            icon: Icons.payment_rounded,
            title: 'You both earn \$20',
            description:
                'Rewards are instantly credited to your wallet balance right after they do their first transaction',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _HowItWorksStep extends StatelessWidget {
  const _HowItWorksStep({
    required this.stepNumber,
    required this.icon,
    required this.title,
    required this.description,
    required this.isLast,
  });

  final int stepNumber;
  final IconData icon;
  final String title;
  final String description;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    context.appColors.primary,
                    context.appColors.primary.withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: context.appColors.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(icon, color: Colors.white, size: 22.sp),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 60.h,
                margin: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.appColors.primary.withValues(alpha: 0.5),
                      context.appColors.primary.withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
          ],
        ),
        16.horizontalSpace,
        Expanded(
          child: Container(
            margin: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildText(
                  text: title,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: context.appColors.text,
                ),
                6.verticalSpace,
                BuildText(
                  text: description,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.textSecondary,
                  maxLines: 3,
                  height: 1.5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
