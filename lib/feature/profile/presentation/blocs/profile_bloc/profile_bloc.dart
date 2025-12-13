import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/core/mixins/auth_mixin.dart';
import 'package:referral_app/feature/profile/presentation/blocs/profile_bloc/profile_bloc_state.dart';
import 'package:referral_app/feature/profile/presentation/blocs/profile_bloc/profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileBlocState> with AuthMixin {
  ProfileBloc() : super(const ProfileInitial()) {
    on<ProfileGetRequested>(_onGetRequested);
  }

  Future<void> _onGetRequested(
    ProfileGetRequested event,
    Emitter<ProfileBlocState> emit,
  ) async {
    try {
      emit(const ProfileLoading());

      final result = await getCurrentAuthUser();
      if (result != null) {
        emit(ProfileSuccess(result));
      } else {
        emit(
          const ProfileFailure(
            UnauthorizedException('Failed to get user profile'),
          ),
        );
      }
    } on AppException catch (e) {
      emit(ProfileFailure(e));
    }
  }
}
