import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_state.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  int page = 0;

  OnboardingCubit() : super(OnboardingInitial());

  void pageChanged(int currentPageValue) {
    page = currentPageValue;
    emit(OnboardingCarouselPageChanged(currentValue: currentPageValue));
  }
}
