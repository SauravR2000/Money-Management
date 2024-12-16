import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';
import 'package:money_management_app/injection/injection_container.dart';

part 'onboarding_state.dart';

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  int page = 0;

  OnboardingCubit() : super(OnboardingInitial());

  void pageChanged(int currentPageValue) {
    page = currentPageValue;
    emit(OnboardingCarouselPageChanged(currentValue: currentPageValue));
  }

  Future<bool> isLoggedIn() async {
    var secureStorage = getIt<SecureLocalStorage>();

    String token = await secureStorage.getStringValue(key: secureStorage.token);

    return token.isNotEmpty;
  }
}
