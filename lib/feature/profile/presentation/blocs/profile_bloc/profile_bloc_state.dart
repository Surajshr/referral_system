import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/shared/data/models/user_model.dart';

sealed class ProfileBlocState {
  const ProfileBlocState();
}

final class ProfileInitial extends ProfileBlocState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileBlocState {
  const ProfileLoading();
}

final class ProfileSuccess extends ProfileBlocState {
  const ProfileSuccess(this.user);

  final UserModel? user;
}

final class ProfileFailure extends ProfileBlocState {
  const ProfileFailure(this.exception);

  final AppException exception;
}
