import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/budget_screen.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Home%20Screen/home_screen.dart';
import 'package:money_management_app/features/profile/presentation/profile_screen.dart';
import 'package:money_management_app/shared_widgets/Custom%20Floating%20Action%20Button/custom_floating_action_button.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late List<Widget> _pages;

  late DashboardCubit _dashboardCubit;

  @override
  void initState() {
    _dashboardCubit = DashboardCubit();
    _pages = [
      Center(
        child: HomeScreen(
          userImageUrl: '',
          dashboardCubit: _dashboardCubit,
        ),
      ),
      Center(child: Text("Transaction")),
      Center(child: BudgetScreen()),
      ProfileScreen(),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: _dashboardCubit,
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: CustomFloatingActionButton(),
          bottomNavigationBar: SafeArea(
            bottom: false,
            child: BottomNavigationBar(
              elevation: 0,
              iconSize: 32,
              backgroundColor: Colors.white,
              currentIndex: _dashboardCubit.selectedIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Theme.of(context).primaryColor,
              unselectedItemColor: Colors.grey,
              onTap: (value) {
                _dashboardCubit.changePage(value);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Icon(Icons.compare_arrows),
                    ),
                    label: 'Transaction      '),
                BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Icon(Icons.pie_chart),
                    ),
                    label: '       Budget'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
            ),
          ),
          body: _pages[_dashboardCubit.selectedIndex],
        );
      },
    );

    // return Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: Column(
    //         children: [
    //           Text("dashboard"),
    // BlocListener<AuthBloc, AuthState>(
    //   bloc: authBloc,
    //   listener: (context, state) {
    //     if (state is AuthSuccess) {
    //       context.router.replaceAll([OnboardingRoute()]);
    //     }
    //   },
    //   child: ElevatedButton(
    //     onPressed: () {
    //       authBloc.add(LogoutEvent());
    //     },
    //     child: const Text("logout"),
    //   ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
