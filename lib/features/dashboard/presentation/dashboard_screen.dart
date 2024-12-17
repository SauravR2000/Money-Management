import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:money_management_app/injection/injection_container.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthBloc authBloc = getIt<AuthBloc>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 312,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 246, 229),
              Color.fromARGB(255, 255, 249, 235)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50)),
        ),
        child: BlocListener<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.router.replaceAll([OnboardingRoute()]);
            }
          },
          child: ElevatedButton(
            onPressed: () {
              authBloc.add(LogoutEvent());
            },
            child: const Text("logout"),
          ),
        ),
      ),
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
