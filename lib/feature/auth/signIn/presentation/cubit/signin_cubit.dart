import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';

import 'package:formz/formz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signin_cubit.freezed.dart';
part 'signin_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());
}
