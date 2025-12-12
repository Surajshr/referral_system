import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/shared/data/models/user_model.dart';

sealed class SignInBlocState {
  const SignInBlocState();
}

final class SignInInitial extends SignInBlocState {
  const SignInInitial();
}

final class SignInLoading extends SignInBlocState {
  const SignInLoading();
}

final class SignInSuccess extends SignInBlocState {
  const SignInSuccess(this.user);

  final UserModel user;
}

final class SignInFailure extends SignInBlocState {
  const SignInFailure(this.exception);

  final AppException exception;
}
