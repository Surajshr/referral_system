import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/auth/signIn/presentation/cubit/signin_cubit.dart';
import 'package:referral_app/feature/auth/signIn/presentation/view/widgets/signin_bottom_card_widget.dart';
import 'package:referral_app/feature/auth/signIn/presentation/view/widgets/signin_form_widget.dart';
import 'package:referral_app/widgets/app_top_section_widget.dart';

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocProvider(
        create: (context) => SignInCubit(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<SignInCubit, SignInState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    60.verticalSpace,
                    AppTopSectionWidget(showBackButton: false),
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
                      child: AppButton(
                        text: 'Sign In',
                        onPressed: () {
                          // context.read<SignInCubit>().signIn();
                        },
                      ),
                    ),
                    32.verticalSpace,
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don\'t have an account? ',
                            style: context.textStyles.bodyText200.copyWith(
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
                            style: context.textStyles.bodyText200.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: context.appColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    32.verticalSpace,
                    SignInBottomCardWidget(),
                    54.verticalSpace,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
