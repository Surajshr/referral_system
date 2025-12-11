import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/core/mixins/auth_mixin.dart';

part 'splash_cubit.freezed.dart';
part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> with AuthMixin {
  SplashCubit() : super(const SplashState());

  void splashNavigationHandler(BuildContext context) async {
    try {
      final isLoggedIn = await isAuthenticated();
      emit(state.copyWith(isLoading: true));

      if (isLoggedIn) {
        context.push(RouteName.dashboardBaseScreen);
      } else {
        context.push(RouteName.signInBaseScreen);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
