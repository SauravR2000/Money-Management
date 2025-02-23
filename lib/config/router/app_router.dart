import 'package:auto_route/auto_route.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        // HomeScreen is generated as HomeRoute because
        // of the replaceInRouteName property
        AutoRoute(page: OnboardingCheckRoute.page, initial: true),
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignupRoute.page),
        AutoRoute(page: PrivacyPolicyRoute.page),
        AutoRoute(
          page: DashboardRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page),
            AutoRoute(page: BudgetRouteUi.page),
            AutoRoute(page: ProfileRoute.page),
          ],
        ),
        AutoRoute(page: AddBudgetRoute.page),
        AutoRoute(page: BudgetDetail.page),
        AutoRoute(page: PincodeRoute.page),
        AutoRoute(page: ConfirmPincodeRoute.page),
        AutoRoute(page: AddExpenseRoute.page),
        AutoRoute(page: AddIncomeRoute.page),
        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: TransactionListingRoute.page),
        AutoRoute(page: TransactionDetailRoute.page),
        AutoRoute(page: ChangePasswordRoute.page),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
