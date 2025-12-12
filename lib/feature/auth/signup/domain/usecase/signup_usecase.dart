import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/auth/signup/domain/entity/signup_entity.dart';
import 'package:referral_app/feature/auth/signup/domain/repository/signup_repository.dart';
import 'package:referral_app/shared/data/models/user_model.dart';

class SignUpUseCase {
  SignUpUseCase(this._repository);
  final SignUpRepository _repository;

  Future<Either<AppException, UserModel>> registerUser({
    required String fullName,
    required String email,
    required String phone,
    required String password,
    required String? referralCode,
  }) {
    final signUpEntity = SignUpEntity(
      fullName: fullName,
      email: email,
      phone: phone,
      password: password,
      referralCode: referralCode,
    );
    return _repository.registerUser(signUpEntity);
  }
}
