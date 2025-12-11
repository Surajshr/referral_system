import 'package:referral_app/feature/auth/signup/domain/repository/signup_repository.dart';
import 'package:referral_app/shared/domain/repositories/auth_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final AuthRepository _authRepository;
  SignUpRepositoryImpl({required AuthRepository authRepository})
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
