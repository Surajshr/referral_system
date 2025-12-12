import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/auth/signIn/domain/entity/signin_entity.dart';
import 'package:referral_app/shared/data/models/user_model.dart';

abstract class SignInRepository {
  Future<Either<AppException, UserModel>> login(SignInEntity signInEntity);
}
