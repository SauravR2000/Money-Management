import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';
import 'package:money_management_app/injection/injection_container.dart';

part 'onboarding_check_state.dart';

@injectable
class OnboardingCheckCubit extends Cubit<OnboardingCheckState> {
  OnboardingCheckCubit() : super(OnboardingCheckInitial());

  void isLoggedIn() async {
    var secureStorage = getIt<SecureLocalStorage>();

    String token = await secureStorage.getStringValue(key: secureStorage.token);

    token.isNotEmpty ? emit(GotoDashboardState()) : emit(GotoOnboardingState());
  }
}
