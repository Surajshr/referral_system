part of 'dashboard_cubit.dart';

@freezed
abstract class DashboardState with _$DashboardState {
  const factory DashboardState({@Default(false) bool isLoading}) =
      _DashboardState;
}
