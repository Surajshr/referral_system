import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/auth/signIn/presentation/cubit/signin_cubit.dart';
import 'package:referral_app/core/formz/formz_exports.dart';

class SignInFormWidget extends StatelessWidget {
  const SignInFormWidget({
    super.key,
    required FocusNode emailFocusNode,
    required this.phoneController,
    required FocusNode passwordFocusNode,
    required this.passwordController,
    required this.state,
  }) : _emailFocusNode = emailFocusNode,
       _passwordFocusNode = passwordFocusNode;

  final FocusNode _emailFocusNode;
  final TextEditingController phoneController;
  final FocusNode _passwordFocusNode;
  final TextEditingController passwordController;
  final SignInState state;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          AppTextField(
            focusNode: _emailFocusNode,
            hintText: ' Email',
            titleText: 'Email Address',
            onChanged: context.read<SignInCubit>().onEmailChanged,
            errorText: !state.email.isPure && state.email.isNotValid
                ? state.email.error?.explain
                : null,
            controller: phoneController,
            keyBoardType: TextInputType.text,
          ),
          16.verticalSpace,
          ValueListenableBuilder(
            valueListenable: context.read<SignInCubit>().isPasswordVisible,
            builder: (context, isPasswordVisible, child) {
              return AppTextField(
                focusNode: _passwordFocusNode,
                titleText: 'Password',
                hintText: 'Password',
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _passwordFocusNode.unfocus(),
                onChanged: context.read<SignInCubit>().onPasswordChanged,
                obscureText: !isPasswordVisible,
                controller: passwordController,
                errorText: !state.password.isPure && state.password.isNotValid
                    ? state.password.error?.explain
                    : null,
                suffixIcon: IconButton(
                  onPressed: context.read<SignInCubit>().togglePassword,
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
