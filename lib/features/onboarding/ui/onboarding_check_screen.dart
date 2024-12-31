import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/dashboard/presentation/dashboard_screen.dart';
import 'package:money_management_app/features/onboarding/cubit/onboarding_check_cubit/onboarding_check_cubit.dart';
import 'package:money_management_app/features/onboarding/ui/onboarding_screen.dart';
import 'package:money_management_app/injection/injection_container.dart';

@RoutePage()
class OnboardingCheckScreen extends StatelessWidget {
  const OnboardingCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnboardingCheckCubit>()..isLoggedIn(),
      child: BlocBuilder<OnboardingCheckCubit, OnboardingCheckState>(
        builder: (context, state) {
          switch (state) {
            case OnboardingLoadingState():
              return CircularProgressIndicator();

            case GotoOnboardingState():
              return OnboardingScreen();

            case GotoDashboardState():
              // return PincodeScreen();
              return DashboardScreen();

            default:
              return OnboardingScreen();
          }
        },
      ),
    );
  }
}
