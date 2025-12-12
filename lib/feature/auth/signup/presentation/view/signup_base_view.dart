import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/core/constants/string_constants.dart';
import 'package:referral_app/feature/auth/signup/presentation/bloc/signup_bloc.dart';
import 'package:referral_app/feature/auth/signup/presentation/bloc/signup_bloc_state.dart';
import 'package:referral_app/feature/auth/signup/presentation/bloc/signup_event.dart';
import 'package:referral_app/feature/auth/signup/presentation/cubit/signup_cubit.dart';
import 'package:referral_app/feature/auth/signup/presentation/view/widgets/signup_form_widget.dart';
import 'package:referral_app/widgets/app_snackbar.dart';
import 'package:referral_app/widgets/app_top_section_widget.dart';
import 'package:referral_app/widgets/loading_overlay.dart';

class SignUpBaseView extends StatefulWidget {
  const SignUpBaseView({super.key});

  @override
  State<SignUpBaseView> createState() => _SignUpBaseViewState();
}

class _SignUpBaseViewState extends State<SignUpBaseView> {
  final _fullNameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _referralCodeFocusNode = FocusNode();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController referralCodeController = TextEditingController();

  @override
  void dispose() {
    _fullNameFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneFocusNode.dispose();
    _passwordFocusNode.dispose();
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    referralCodeController.dispose();
    _referralCodeFocusNode.dispose();
    super.dispose();
  }

  void _handleSignUp(BuildContext context) {
    final referralCode = referralCodeController.text.trim();
    context.read<SignUpBloc>().add(
      SignUpRegisterRequested(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(),
        password: passwordController.text,
        referralCode: referralCode.isEmpty ? null : referralCode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignUpBloc()),
          BlocProvider(create: (context) => SignUpCubit()),
        ],
        child: BlocListener<SignUpBloc, SignUpBlocState>(
          listenWhen: (previous, current) =>
              current is SignUpSuccess || current is SignUpFailure,
          listener: (context, blocState) {
            if (blocState is SignUpSuccess) {
              context.go(RouteName.dashboardBaseScreen);
            } else if (blocState is SignUpFailure) {
              AppSnackbar.showError(
                context,
                kDebugMode
                    ? blocState.exception.message
                    : StringConstant.defaultErrorMsg,
              );
            }
          },
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      60.verticalSpace,
                      const AppTopSectionWidget(),
                      30.verticalSpace,
                      Center(
                        child: Image.asset(
                          ImageConstants.referralBonus,
                          width: 100.w,
                          height: 100.h,
                        ),
                      ),
                      20.verticalSpace,
                      BuildText(
                        text: 'Join the Community',
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        textAlign: TextAlign.center,
                      ),
                      10.verticalSpace,
                      BuildText(
                        text:
                            'Create your account and start earning rewards by inviting friends to join xuno platform.',
                        fontSize: 16.sp,
                        color: context.appColors.textSecondary,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        height: 1.5,
                      ),
                      16.verticalSpace,
                      _buildBonusCard(context),
                      32.verticalSpace,
                      BlocBuilder<SignUpCubit, SignUpState>(
                        builder: (context, state) {
                          return SignUpFormWidget(
                            signUpState: state,
                            fullNameController: fullNameController,
                            fullNameFocusNode: _fullNameFocusNode,
                            emailController: emailController,
                            emailFocusNode: _emailFocusNode,
                            phoneController: phoneController,
                            phoneFocusNode: _phoneFocusNode,
                            passwordController: passwordController,
                            passwordFocusNode: _passwordFocusNode,
                            referralCodeController: referralCodeController,
                            referralCodeFocusNode: _referralCodeFocusNode,
                          );
                        },
                      ),
                      32.verticalSpace,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: BlocBuilder<SignUpBloc, SignUpBlocState>(
                          buildWhen: (previous, current) =>
                              current is SignUpLoading ||
                              current is SignUpInitial,
                          builder: (context, blocState) {
                            return AppButton(
                              text: 'Create Account',
                              onPressed: () => _handleSignUp(context),
                            );
                          },
                        ),
                      ),
                      32.verticalSpace,
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style: context.textStyles.bodyText200.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: context.appColors.textSecondary,
                              ),
                            ),
                            TextSpan(
                              text: 'Sign In',
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.pop();
                                },
                              style: context.textStyles.bodyText200.copyWith(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: context.appColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      54.verticalSpace,
                    ],
                  ),
                ),
              ),
              BlocSelector<SignUpBloc, SignUpBlocState, bool>(
                selector: (state) => state is SignUpLoading,
                builder: (context, isLoading) {
                  return isLoading
                      ? const LoadingOverlay()
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBonusCard(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: context.appColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: context.appColors.border),
        ),
        child: Row(
          children: [
            Image.asset(
              ImageConstants.giftBoxIcon,
              width: 70.w,
              height: 70.w,
              color: context.appColors.container,
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildText(
                    text: 'Get \$10 Bonus',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                  ),
                  6.verticalSpace,
                  BuildText(
                    text:
                        'Referred by a friend? You\'ll receive a \$10 bonus once you complete your first transaction!',
                    fontSize: 14.sp,
                    height: 1.5,
                    color: context.appColors.textSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
