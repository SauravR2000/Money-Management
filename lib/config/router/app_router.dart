import 'package:auto_route/auto_route.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property
        AutoRoute(
          initial: true,
          page: Onboarding.page,
        ),
      ];

  @override
  List<AutoRouteGuard> get guards => [
        // optionally add root guards here
      ];
}
