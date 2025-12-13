import 'package:dartz/dartz.dart';
// import 'package:referral_app/core/constants/api_constants.dart';
// import 'package:referral_app/core/constants/environment_constants.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
// import 'package:referral_app/core/network/client/base_client.dart';
import 'package:referral_app/feature/auth/signIn/domain/entity/signin_entity.dart';
import 'package:referral_app/feature/auth/signIn/domain/repository/signin_repository.dart';
import 'package:referral_app/shared/data/models/user_model.dart';
import 'package:referral_app/shared/domain/repositories/auth_repository.dart';

class SignInRepositoryImpl implements SignInRepository {
  final AuthRepository _authRepository;
  SignInRepositoryImpl({
    required AuthRepository authRepository,
    // required BaseClient client,
  }) : _authRepository = authRepository;
  //  _client = client;

  // final BaseClient _client;
  @override
  Future<Either<AppException, UserModel>> login(
    SignInEntity signInEntity,
  ) async {
    return await _authRepository.login(
      email: signInEntity.email,
      password: signInEntity.password,
    );
  }

  /* 
  This the sample code for the login api using the base client.
  if we use rest API in this app when we can use this code.
  */

  // @override
  // Future<Either<UserModel, Failure>> login({
  //   String? limit,
  //   String? page,
  // }) async {
  //   final response = await _client.getRequest(
  //     baseUrl: EnvironmentConstants.baseUrl,
  //     path: ApiConstants.kSignUp,
  //     queryParameters: {'limit': limit, 'page': page},
  //   );
  //   return getParsedData(response, UserModel.fromJson);
  // }
}
