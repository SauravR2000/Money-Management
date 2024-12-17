part of 'onboarding_check_cubit.dart';

@immutable
sealed class OnboardingCheckState {}

final class OnboardingCheckInitial extends OnboardingCheckState {}

class OnboardingLoadingState extends OnboardingCheckState {}

class GotoOnboardingState extends OnboardingCheckState {}

class GotoDashboardState extends OnboardingCheckState {}
