import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:referral_app/feature/profile/presentation/blocs/profile_bloc/profile_bloc_state.dart';
import 'package:referral_app/feature/profile/presentation/blocs/profile_bloc/profile_event.dart';
import 'package:referral_app/feature/profile/presentation/widgets/logout_dialog.dart';
import 'package:referral_app/feature/profile/presentation/widgets/profile_header.dart';
import 'package:referral_app/feature/profile/presentation/widgets/profile_info_card.dart';
import 'package:referral_app/feature/profile/presentation/widgets/profile_shimmer.dart';
import 'package:referral_app/widgets/app_top_section_widget.dart';

class ProfileBaseView extends StatelessWidget {
  const ProfileBaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: const _ProfileContent(),
    );
  }
}

class _ProfileContent extends StatefulWidget {
  const _ProfileContent();

  @override
  State<_ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<_ProfileContent> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(const ProfileGetRequested());
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => const LogoutDialog(),
    );
  }

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
                  prefix: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: context.appColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(360.r),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: context.appColors.text,
                      ),
                    ),
                  ),
                  title: 'Profile',
                ),
                16.verticalSpace,
              ],
            ),
          ),
          Expanded(
            child: BlocBuilder<ProfileBloc, ProfileBlocState>(
              builder: (context, state) {
                return switch (state) {
                  ProfileInitial() || ProfileLoading() => _buildLoadingState(),
                  ProfileSuccess() => _buildSuccessState(context, state),
                  ProfileFailure() => _buildErrorState(context, state),
                };
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: const ProfileShimmer(),
    );
  }

  Widget _buildSuccessState(BuildContext context, ProfileSuccess state) {
    final user = state.user;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileHeader(name: user?.fullName ?? 'User'),

          24.verticalSpace,

          BuildText(
            text: 'Personal Information',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.appColors.text,
          ),
          12.verticalSpace,

          ProfileInfoCard(
            showArrow: false,
            icon: Icons.person_outline_rounded,
            label: 'Full Name',
            value: user?.fullName ?? 'N/A',
          ),
          12.verticalSpace,

          ProfileInfoCard(
            showArrow: false,
            icon: Icons.email_outlined,
            label: 'Email',
            value: user?.email ?? 'N/A',
          ),
          12.verticalSpace,

          ProfileInfoCard(
            icon: Icons.phone_outlined,
            label: 'Phone Number',
            value: user?.phone ?? 'N/A',
            showArrow: false,
          ),

          24.verticalSpace,

          BuildText(
            text: 'Account Settings',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: context.appColors.text,
          ),
          12.verticalSpace,

          ProfileInfoCard(
            icon: Icons.lock_outline_rounded,
            label: 'Change Password',
            value: '••••••••',
            onTap: () {
              // TODO: Navigate to change password
            },
          ),
          12.verticalSpace,

          ProfileInfoCard(
            icon: Icons.notifications_outlined,
            label: 'Notifications',
            value: 'Enabled',
            onTap: () {
              // TODO: Navigate to notification settings
            },
          ),

          32.verticalSpace,

          // Logout Button
          Container(
            width: double.infinity,
            height: 56.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: context.appColors.error, width: 2),
            ),
            child: ElevatedButton(
              onPressed: () => _showLogoutDialog(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.logout_rounded,
                    color: context.appColors.error,
                    size: 20.sp,
                  ),
                  12.horizontalSpace,
                  BuildText(
                    text: 'Logout',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: context.appColors.error,
                  ),
                ],
              ),
            ),
          ),

          32.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, ProfileFailure state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 80.sp,
              color: context.appColors.error,
            ),
            24.verticalSpace,
            BuildText(
              text: 'Failed to Load Profile',
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: context.appColors.text,
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,
            BuildText(
              text: state.exception.message,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: context.appColors.textSecondary,
              textAlign: TextAlign.center,
            ),
            32.verticalSpace,
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  context.read<ProfileBloc>().add(const ProfileGetRequested());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.appColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: BuildText(
                  text: 'Retry',
                  fontSize: 16.sp,
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
