import 'package:dartz/dartz.dart';
import 'package:referral_app/feature/auth/signIn/domain/repository/login_repository.dart';

class SignInUseCase {
  SignInUseCase(this._repository);
  final SignInRepository _repository;

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
