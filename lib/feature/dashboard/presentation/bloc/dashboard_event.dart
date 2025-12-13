sealed class DashboardBlocEvent {
  const DashboardBlocEvent();
}

final class DashboardInitRequested extends DashboardBlocEvent {
  const DashboardInitRequested({required this.userId});

  final String userId;
}
