import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/core/formz/formz_exports.dart';
import 'package:referral_app/feature/auth/signup/presentation/cubit/signup_cubit.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
    required this.fullNameController,
    required FocusNode fullNameFocusNode,
    required this.emailController,
    required FocusNode emailFocusNode,
    required this.phoneController,
    required FocusNode phoneFocusNode,
    required this.passwordController,
    required FocusNode passwordFocusNode,
    required this.referralCodeController,
    required FocusNode referralCodeFocusNode,
    required this.signUpState,
  }) : _fullNameFocusNode = fullNameFocusNode,
       _emailFocusNode = emailFocusNode,
       _phoneFocusNode = phoneFocusNode,
       _passwordFocusNode = passwordFocusNode,
       _referralCodeFocusNode = referralCodeFocusNode;

  final TextEditingController fullNameController;
  final FocusNode _fullNameFocusNode;
  final TextEditingController emailController;
  final FocusNode _emailFocusNode;
  final TextEditingController phoneController;
  final FocusNode _phoneFocusNode;
  final TextEditingController passwordController;
  final FocusNode _passwordFocusNode;
  final FocusNode _referralCodeFocusNode;
  final TextEditingController referralCodeController;
  final SignUpState signUpState;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          AppTextField(
            focusNode: _fullNameFocusNode,
            hintText: 'Enter your full name',
            titleText: 'Full Name',
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => _emailFocusNode.requestFocus(),
            onChanged: context.read<SignUpCubit>().onFullNameChanged,
            errorText:
                !signUpState.fullName.isPure && signUpState.fullName.isNotValid
                ? signUpState.fullName.error?.explain
                : null,
            controller: fullNameController,
            keyBoardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
          ),
          16.verticalSpace,
          AppTextField(
            focusNode: _emailFocusNode,
            hintText: 'suraj@example.com',
            titleText: 'Email Address',
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => _phoneFocusNode.requestFocus(),
            onChanged: context.read<SignUpCubit>().onEmailChanged,
            errorText: !signUpState.email.isPure && signUpState.email.isNotValid
                ? signUpState.email.error?.explain
                : null,
            controller: emailController,
            keyBoardType: TextInputType.emailAddress,
          ),
          16.verticalSpace,
          AppTextField(
            focusNode: _phoneFocusNode,
            hintText: '+98*******',
            titleText: 'Phone Number',
            textInputAction: TextInputAction.next,
            onSubmitted: (_) => _passwordFocusNode.requestFocus(),
            onChanged: context.read<SignUpCubit>().onPhoneChanged,
            errorText: !signUpState.phone.isPure && signUpState.phone.isNotValid
                ? signUpState.phone.error?.explain
                : null,
            controller: phoneController,
            keyBoardType: TextInputType.phone,
          ),
          16.verticalSpace,
          ValueListenableBuilder(
            valueListenable: context.read<SignUpCubit>().isPasswordVisible,
            builder: (context, isPasswordVisible, child) {
              return AppTextField(
                focusNode: _passwordFocusNode,
                titleText: 'Password',
                hintText: 'Password',
                textInputAction: TextInputAction.next,
                onSubmitted: (_) => _referralCodeFocusNode.requestFocus(),
                onChanged: context.read<SignUpCubit>().onPasswordChanged,
                obscureText: !isPasswordVisible,
                controller: passwordController,
                errorText:
                    !signUpState.password.isPure &&
                        signUpState.password.isNotValid
                    ? signUpState.password.error?.explain
                    : null,
                suffixIcon: IconButton(
                  onPressed: context.read<SignUpCubit>().togglePassword,
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              );
            },
          ),
          16.verticalSpace,
          AppTextField(
            focusNode: _referralCodeFocusNode,
            hintText: 'Enter referral code',
            titleText: 'Referral Code (Optional)',
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _referralCodeFocusNode.unfocus(),
            controller: referralCodeController,
            keyBoardType: TextInputType.text,
            textCapitalization: TextCapitalization.characters,
          ),
        ],
      ),
    );
  }
}
