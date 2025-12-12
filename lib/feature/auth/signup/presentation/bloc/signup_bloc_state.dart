import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/shared/data/models/user_model.dart';

sealed class SignUpBlocState {
  const SignUpBlocState();
}

final class SignUpInitial extends SignUpBlocState {
  const SignUpInitial();
}

final class SignUpLoading extends SignUpBlocState {
  const SignUpLoading();
}

final class SignUpSuccess extends SignUpBlocState {
  const SignUpSuccess(this.user);

  final UserModel user;
}

final class SignUpFailure extends SignUpBlocState {
  const SignUpFailure(this.exception);

  final AppException exception;
}
