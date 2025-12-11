import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/cubit/theme_cubit.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/auth/signup/presentation/cubit/signup_cubit.dart';
import 'package:referral_app/feature/auth/signup/presentation/view/widgets/signup_form_widget.dart';
import 'package:referral_app/widgets/app_top_section_widget.dart';

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
  void initState() {
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // appBar: AppBar(
      //   title: const Text('Sign In'),
      //   // lib/feature/auth/signIn/presentation/view/signin_base_view.dart
      //   actions: [
      //     BlocBuilder<ThemeCubit, ThemeMode>(
      //       builder: (context, themeMode) {
      //         IconData icon;
      //         String tooltip;

      //         switch (themeMode) {
      //           case ThemeMode.light:
      //             icon = Icons.light_mode;
      //             tooltip = 'Light Mode';
      //           case ThemeMode.dark:
      //             icon = Icons.dark_mode;
      //             tooltip = 'Dark Mode';
      //           case ThemeMode.system:
      //             icon = Icons.brightness_auto;
      //             tooltip = 'System Mode';
      //         }

      //         return IconButton(
      //           icon: Icon(icon),
      //           tooltip: tooltip,
      //           onPressed: () => context.read<ThemeCubit>().toggleTheme(),
      //         );
      //       },
      //     ),
      //   ],
      // ),
      body: BlocProvider(
        create: (context) => SignUpCubit(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    60.verticalSpace,
                    AppTopSectionWidget(),
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
                    Padding(
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
                    ),
                    32.verticalSpace,
                    SignUpFormWidget(
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
                    ),
                    32.verticalSpace,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: AppButton(
                        text: 'Create Account',
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
              );
            },
          ),
        ),
      ),
    );
  }
}
