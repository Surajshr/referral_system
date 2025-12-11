import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:referral_app/feature/auth/signIn/domain/repository/signin_repository.dart';
import 'package:referral_app/shared/domain/repositories/auth_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final AuthRepository _authRepository;
  SignInRepositoryImpl({required AuthRepository authRepository})
    : _authRepository = authRepository;
  // final BaseClient _client;
  // SignInRepositoryImpl(this._client);

  // @override
  // Future<Either<SignInModel, Failure>> login(SignInEntity signInEntity) async {
  //   final response = await _client.postRequest(
  //     baseUrl: EnvironmentConstants.baseUrl,
  //     path: ApiConstants.kSignIn,
  //     data: signInEntity.toJson(),
  //   );
  //   return getParsedData(response, SignInModel.fromJson);
  // }
}
