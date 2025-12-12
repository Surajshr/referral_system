import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/core/constants/string_constants.dart';
import 'package:referral_app/feature/auth/signIn/presentation/bloc/signin_bloc.dart';
import 'package:referral_app/feature/auth/signIn/presentation/bloc/signin_bloc_state.dart';
import 'package:referral_app/feature/auth/signIn/presentation/bloc/signin_event.dart';
import 'package:referral_app/feature/auth/signIn/presentation/cubit/signin_cubit.dart';
import 'package:referral_app/feature/auth/signIn/presentation/view/widgets/signin_bottom_card_widget.dart';
import 'package:referral_app/feature/auth/signIn/presentation/view/widgets/signin_form_widget.dart';
import 'package:referral_app/widgets/app_snackbar.dart';
import 'package:referral_app/widgets/app_top_section_widget.dart';
import 'package:referral_app/widgets/loading_overlay.dart';

class SignInBaseView extends StatefulWidget {
  const SignInBaseView({super.key});

  @override
  State<SignInBaseView> createState() => _SignInBaseViewState();
}

class _SignInBaseViewState extends State<SignInBaseView> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn(BuildContext context) {
    context.read<SignInBloc>().add(
      SignInRequested(
        email: phoneController.text.trim(),
        password: passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => SignInBloc()),
          BlocProvider(create: (context) => SignInCubit()),
        ],
        child: BlocListener<SignInBloc, SignInBlocState>(
          listenWhen: (previous, current) =>
              current is SignInSuccess || current is SignInFailure,
          listener: (context, blocState) {
            if (blocState is SignInSuccess) {
              context.go(RouteName.dashboardBaseScreen);
            } else if (blocState is SignInFailure) {
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
              BlocBuilder<SignInCubit, SignInState>(
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          60.verticalSpace,
                          const AppTopSectionWidget(showBackButton: false),
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
                            text: 'Welcome Back!',
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                          ),
                          10.verticalSpace,
                          BuildText(
                            text:
                                'Sign in to access your referral rewards and start earning together',
                            fontSize: 16.sp,
                            color: context.appColors.textSecondary,
                            fontWeight: FontWeight.w400,
                            textAlign: TextAlign.center,
                            height: 1.5,
                          ),
                          32.verticalSpace,
                          SignInFormWidget(
                            state: state,
                            emailFocusNode: _emailFocusNode,
                            phoneController: phoneController,
                            passwordFocusNode: _passwordFocusNode,
                            passwordController: passwordController,
                          ),
                          32.verticalSpace,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: BlocBuilder<SignInBloc, SignInBlocState>(
                              buildWhen: (previous, current) =>
                                  current is SignInLoading ||
                                  current is SignInInitial,
                              builder: (context, blocState) {
                                return AppButton(
                                  text: 'Sign In',
                                  onPressed: () => _handleSignIn(context),
                                );
                              },
                            ),
                          ),
                          32.verticalSpace,
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Don\'t have an account? ',
                                  style: context.textStyles.bodyText200
                                      .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: context.appColors.textSecondary,
                                      ),
                                ),
                                TextSpan(
                                  text: 'Sign Up',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      context.push(RouteName.signUpBaseScreen);
                                    },
                                  style: context.textStyles.bodyText200
                                      .copyWith(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        color: context.appColors.primary,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          32.verticalSpace,
                          const SignInBottomCardWidget(),
                          54.verticalSpace,
                        ],
                      ),
                    ),
                  );
                },
              ),
              BlocSelector<SignInBloc, SignInBlocState, bool>(
                selector: (state) => state is SignInLoading,
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
}
