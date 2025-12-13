import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/mixins/auth_mixin.dart';
import 'package:referral_app/feature/profile/presentation/blocs/logout_bloc/logout_event.dart';
import 'package:referral_app/feature/profile/presentation/blocs/logout_bloc/logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> with AuthMixin {
  LogoutBloc() : super(const LogoutInitial()) {
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LogoutState> emit,
  ) async {
    try {
      emit(const LogoutLoading());

      final result = await logout();
      if (result) {
        emit(LogoutSuccess());
      } else {
        emit(const LogoutFailure(UnauthorizedException('Failed to logout')));
      }
    } on AppException catch (e) {
      emit(
        LogoutFailure(
          kDebugMode ? const UnauthorizedException('Failed to logout') : e,
        ),
      );
    }
  }
}
