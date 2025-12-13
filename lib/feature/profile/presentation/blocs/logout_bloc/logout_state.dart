import 'package:referral_app/core/exceptions/app_exception.dart';

sealed class LogoutState {
  const LogoutState();
}

final class LogoutInitial extends LogoutState {
  const LogoutInitial();
}

final class LogoutLoading extends LogoutState {
  const LogoutLoading();
}

final class LogoutSuccess extends LogoutState {
  const LogoutSuccess();
}

final class LogoutFailure extends LogoutState {
  const LogoutFailure(this.exception);

  final AppException exception;
}
