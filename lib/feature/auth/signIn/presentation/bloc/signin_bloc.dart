import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/core/di/di.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/auth/signIn/domain/usecase/signin_usecase.dart';
import 'package:referral_app/feature/auth/signIn/presentation/bloc/signin_bloc_state.dart';
import 'package:referral_app/feature/auth/signIn/presentation/bloc/signin_event.dart';

class SignInBloc extends Bloc<SignInEvent, SignInBlocState> {
  SignInBloc() : super(const SignInInitial()) {
    on<SignInRequested>(_onSignInRequested);
  }
  final SignInUseCase _signInUseCase = di<SignInUseCase>();

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<SignInBlocState> emit,
  ) async {
    try {
      emit(const SignInLoading());

      final result = await _signInUseCase.login(
        email: event.email,
        password: event.password,
      );

      result.fold(
        (exception) => emit(SignInFailure(exception)),
        (user) => emit(SignInSuccess(user)),
      );
    } on AppException catch (e) {
      emit(SignInFailure(e));
    }
  }
}
