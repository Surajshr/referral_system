import 'package:referral_app/core/exceptions/app_exception.dart';
import 'package:referral_app/feature/dashboard/domain/entities/dashboard_entity.dart';

sealed class DashboardBlocState {
  const DashboardBlocState();
}

final class DashboardInitial extends DashboardBlocState {
  const DashboardInitial();
}

final class DashboardLoading extends DashboardBlocState {
  const DashboardLoading();
}

final class DashboardSuccess extends DashboardBlocState {
  const DashboardSuccess(this.dashboardEntity);

  final DashboardEntity dashboardEntity;
}

final class DashboardFailure extends DashboardBlocState {
  const DashboardFailure(this.exception);

  final AppException exception;
}
