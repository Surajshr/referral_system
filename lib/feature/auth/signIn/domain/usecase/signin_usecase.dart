import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/auth/signIn/domain/entity/signin_entity.dart';
import 'package:referral_app/feature/auth/signIn/domain/repository/signin_repository.dart';
import 'package:referral_app/shared/data/models/user_model.dart';

class SignInUseCase {
  SignInUseCase(this._repository);
  final SignInRepository _repository;

  Future<Either<AppException, UserModel>> login({
    required String email,
    required String password,
  }) {
    final signInEntity = SignInEntity(email: email, password: password);
    return _repository.login(signInEntity);
  }
}
