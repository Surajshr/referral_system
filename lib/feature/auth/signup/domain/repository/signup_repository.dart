import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/auth/signup/domain/entity/signup_entity.dart';
import 'package:referral_app/shared/data/models/user_model.dart';

abstract class SignUpRepository {
  Future<Either<AppException, UserModel>> registerUser(
    SignUpEntity signUpEntity,
  );
}
