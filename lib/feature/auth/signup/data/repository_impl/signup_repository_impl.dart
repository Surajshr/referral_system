import 'package:dartz/dartz.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/auth/signup/domain/entity/signup_entity.dart';
import 'package:referral_app/feature/auth/signup/domain/repository/signup_repository.dart';
import 'package:referral_app/shared/data/models/user_model.dart';
import 'package:referral_app/shared/domain/repositories/auth_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final AuthRepository _authRepository;
  SignUpRepositoryImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;
  // final BaseClient _client;
  // SignInRepositoryImpl(this._client);

  @override
  Future<Either<AppException, UserModel>> registerUser(
    SignUpEntity signUpEntity,
  ) async {
    return await _authRepository.registerUser(
      fullName: signUpEntity.fullName,
      email: signUpEntity.email,
      phone: signUpEntity.phone,
      password: signUpEntity.password,
      referralCode: signUpEntity.referralCode,
    );
  }
}
