part of 'route_imports.dart';

/// Global navigator key for the app
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Main application router
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RouteName.splashBaseScreen,
  debugLogDiagnostics: false,
  routes: [
    GoRoute(
      path: RouteName.splashBaseScreen,
      builder: (context, state) => const SplashBaseScreen(),
    ),
    GoRoute(
      path: RouteName.signInBaseScreen,
      builder: (context, state) => const SignInBaseView(),
    ),
    GoRoute(
      path: RouteName.signUpBaseScreen,
      builder: (context, state) => const SignUpBaseView(),
    ),
    GoRoute(
      path: RouteName.dashboardBaseScreen,
      builder: (context, state) => const DashboardBaseScreen(),
    ),
    GoRoute(
      path: RouteName.transactionBaseScreen,
      builder: (context, state) => const TransactionBaseView(),
    ),
    GoRoute(
      path: RouteName.profileBaseScreen,
      builder: (context, state) => const ProfileBaseView(),
    ),
  ],
);
