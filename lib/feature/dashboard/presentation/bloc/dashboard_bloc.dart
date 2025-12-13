import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/core/di/di.dart';
import 'package:referral_app/feature/dashboard/domain/usecases/dashboard_usecase.dart';
import 'package:referral_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:referral_app/feature/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardBlocEvent, DashboardBlocState> {
  DashboardBloc() : super(const DashboardInitial()) {
    on<DashboardInitRequested>(_onInitRequested);
  }
  final DashboardUsecase _dashboardUsecase = di<DashboardUsecase>();

  Future<void> _onInitRequested(
    DashboardInitRequested event,
    Emitter<DashboardBlocState> emit,
  ) async {
    emit(const DashboardLoading());

    final result = await _dashboardUsecase.initDashboard(event.userId);

    result.fold(
      (exception) => emit(DashboardFailure(exception)),
      (dashboardEntity) => emit(DashboardSuccess(dashboardEntity)),
    );
  }
}
