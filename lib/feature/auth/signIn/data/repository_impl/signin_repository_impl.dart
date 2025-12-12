import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/auth/signIn/domain/entity/signin_entity.dart';
import 'package:referral_app/feature/auth/signIn/domain/repository/signin_repository.dart';
import 'package:referral_app/shared/data/models/user_model.dart';
import 'package:referral_app/shared/domain/repositories/auth_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final AuthRepository _authRepository;
  SignInRepositoryImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;
  @override
  Future<Either<AppException, UserModel>> login(
    SignInEntity signInEntity,
  ) async {
    return await _authRepository.login(
      email: signInEntity.email,
      password: signInEntity.password,
    );
  }
}
