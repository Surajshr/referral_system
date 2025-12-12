import 'package:referral_app/app/view/app_imports.dart';

class TotalEarningsCard extends StatelessWidget {
  const TotalEarningsCard({super.key, required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.all(32.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: context.appColors.cardGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: context.appColors.shadow.withValues(alpha: 0.3),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BuildText(
                text: 'Total Earnings',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white.withValues(alpha: 0.85),
              ),
              8.verticalSpace,
              BuildText(
                text: amount,
                fontSize: 52.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Image.asset(
              ImageConstants.dollarIcon,
              width: 28.w,
              height: 28.h,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
