import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/profile/presentation/blocs/logout_bloc/logout_bloc.dart';
import 'package:referral_app/feature/profile/presentation/blocs/logout_bloc/logout_event.dart';
import 'package:referral_app/feature/profile/presentation/blocs/logout_bloc/logout_state.dart';
import 'package:referral_app/widgets/app_snackbar.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutBloc(),
      child: const _LogoutDialogContent(),
    );
  }
}

class _LogoutDialogContent extends StatelessWidget {
  const _LogoutDialogContent();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.of(context).pop();
          context.go(RouteName.signInBaseScreen);
        } else if (state is LogoutFailure) {
          AppSnackbar.showError(context, state.exception.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is LogoutLoading;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Container(
            padding: EdgeInsets.all(24.r),
            decoration: BoxDecoration(
              color: context.appColors.surface,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: context.appColors.error.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.logout_rounded,
                    color: context.appColors.error,
                    size: 32.sp,
                  ),
                ),

                20.verticalSpace,

                BuildText(
                  text: 'Logout',
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: context.appColors.text,
                ),

                12.verticalSpace,

                BuildText(
                  text: 'Are you sure you want to logout from your account?',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: context.appColors.textSecondary,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  height: 1.5,
                ),

                24.verticalSpace,

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: context.appColors.border,
                            width: 1.5,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: isLoading
                              ? null
                              : () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: BuildText(
                            text: 'Cancel',
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: isLoading
                                ? context.appColors.textMuted
                                : context.appColors.text,
                          ),
                        ),
                      ),
                    ),

                    12.horizontalSpace,

                    Expanded(
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: isLoading
                              ? context.appColors.error.withValues(alpha: 0.5)
                              : context.appColors.error,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: ElevatedButton(
                          onPressed: () => context.read<LogoutBloc>().add(
                            const LogoutRequested(),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            disabledBackgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 20.w,
                                  height: 20.w,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : BuildText(
                                  text: 'Logout',
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
