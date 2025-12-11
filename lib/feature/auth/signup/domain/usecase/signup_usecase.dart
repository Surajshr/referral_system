import 'package:referral_app/feature/auth/signup/domain/repository/signup_repository.dart';

class SignUpUseCase {
  SignUpUseCase(this._repository);
  final SignUpRepository _repository;

  // Future<Either<SignInModel, Failure>> signIn({
  //   required String email,
  //   required String password,
  //   required bool remember,
  // }) {
  //   final signInEntity = SignInEntity(
  //     email: email.trim(),
  //     password: password.trim(),
  //     remember: remember,
  //   );
  //   return _repository.login(signInEntity);
  // }
}
