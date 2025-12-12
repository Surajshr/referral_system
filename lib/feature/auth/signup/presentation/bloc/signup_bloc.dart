import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/core/di/di.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/auth/signup/domain/usecase/signup_usecase.dart';
import 'package:referral_app/feature/auth/signup/presentation/bloc/signup_event.dart';
import 'package:referral_app/feature/auth/signup/presentation/bloc/signup_bloc_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpBlocState> {
  SignUpBloc() : super(const SignUpInitial()) {
    on<SignUpRegisterRequested>(_onRegisterRequested);
  }
  final SignUpUseCase _signUpUseCase = di<SignUpUseCase>();

  Future<void> _onRegisterRequested(
    SignUpRegisterRequested event,
    Emitter<SignUpBlocState> emit,
  ) async {
    try {
      emit(const SignUpLoading());

      final result = await _signUpUseCase.registerUser(
        fullName: event.fullName,
        email: event.email,
        phone: event.phone,
        password: event.password,
        referralCode: event.referralCode,
      );
      result.fold(
        (exception) => emit(SignUpFailure(exception)),
        (user) => emit(SignUpSuccess(user)),
      );
    } on AppException catch (e) {
      emit(SignUpFailure(e));
    }
  }
}
