part of 'onboarding_cubit.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

class OnboardingCarouselPageChanged extends OnboardingState {
  final int currentValue;

  OnboardingCarouselPageChanged({required this.currentValue});
}
