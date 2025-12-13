import 'package:referral_app/app/view/app_imports.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.appColors.textMuted.withValues(alpha: 0.3),
      highlightColor: context.appColors.textMuted.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header Shimmer
          Center(
            child: Column(
              children: [
                Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: context.appColors.textMuted,
                    borderRadius: BorderRadius.circular(360.r),
                  ),
                ),
                16.verticalSpace,
                Container(
                  width: 120.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: context.appColors.textMuted,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),

          24.verticalSpace,

          // Personal Information Section Title
          Container(
            width: 150.w,
            height: 18.h,
            decoration: BoxDecoration(
              color: context.appColors.textMuted,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          12.verticalSpace,

          // Personal Information Cards
          _buildShimmerCard(context),
          12.verticalSpace,
          _buildShimmerCard(context),
          12.verticalSpace,
          _buildShimmerCard(context),

          24.verticalSpace,

          // Account Settings Section Title
          Container(
            width: 150.w,
            height: 18.h,
            decoration: BoxDecoration(
              color: context.appColors.textMuted,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          12.verticalSpace,

          // Account Settings Cards
          _buildShimmerCard(context),
          12.verticalSpace,
          _buildShimmerCard(context),

          32.verticalSpace,

          // Logout Button Shimmer
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              color: context.appColors.textMuted,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),

          32.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildShimmerCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: context.appColors.textMuted,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(360.r),
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 80.w,
                  height: 12.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                8.verticalSpace,
                Container(
                  width: 120.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}
