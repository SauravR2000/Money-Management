import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/onboarding/cubit/onboarding_cubit.dart';
import 'package:money_management_app/features/onboarding/ui/onboarding.dart';
import 'package:money_management_app/injection/injection_container.dart';

@RoutePage()
class OnboardingCheckScreen extends StatelessWidget {
  const OnboardingCheckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnboardingCubit>()..isLoggedIn(),
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) {
          // switch()
          return Onboarding();
        },
      ),
    );
  }
}
