import 'package:referral_app/app/view/app_imports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Container(
        width: 1.sw,
        padding: EdgeInsets.all(24.r),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              context.appColors.primary,
              context.appColors.primary.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(18.r),
          boxShadow: [
            BoxShadow(
              color: context.appColors.shadow.withValues(alpha: 0.2),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: Center(
                child: BuildText(
                  text: name.isNotEmpty ? name[0].toUpperCase() : 'U',
                  fontSize: 36.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
