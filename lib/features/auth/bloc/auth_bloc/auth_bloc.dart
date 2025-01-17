import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/core/network/auth_service.dart';
import 'package:money_management_app/core/network/execute_api_call.dart';
import 'package:money_management_app/core/storage/local_storage.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';
import 'package:money_management_app/main.dart';
import 'package:money_management_app/utils/constants/strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._authservice,
    this._secureLocalStorage,
    this._localStorage,
  ) : super(AuthInitial()) {
    on<SignupEvent>(_signupEvent);
    on<LoginEvent>(_loginEvent);
    on<LogoutEvent>(_logoutEvent);
    on<ChangePasswordEvent>(_changePasswordEvent);
  }

  final AuthService _authservice;
  final SecureLocalStorage _secureLocalStorage;
  final LocalStorageSharedPref _localStorage;

  FutureOr<void> _signupEvent(
    SignupEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    await executeApiCall(
      apiCall: () => _authservice.signupWithEmailAndPassword(
        email: event.email,
        password: event.password,
        name: event.userName,
      ),
      onSuccess: (response) {
        log("signup success = $response");

        storeUserCredentials(response);

        emit(AuthSuccess());
      },
      onError: (error) {
        log("signup error = $error");
        emit(AuthError(error: error));
      },
    );
  }

  FutureOr<void> _loginEvent(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    await executeApiCall(
      apiCall: () => _authservice.signinWithEmailAndPassword(
        email: event.email,
        password: event.password,
      ),
      onSuccess: (response) {
        log("Login response: ${response.user}");

        //register user credential in local storage
        storeUserCredentials(response);

        emit(AuthSuccess());
      },
      onError: (error) {
        log("Login failed: $error");
        emit(AuthError(error: error));
      },
    );
  }

  FutureOr<void> _logoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    await executeApiCall(
      apiCall: () => _authservice.signOut(),
      onSuccess: (response) {
        log("logout success");
        removeUserCredentialFromLocalStorag();
        emit(AuthSuccess());
      },
      onError: (error) {
        log("Login failed: $error");
        emit(AuthError(error: error));
      },
    );
  }

  void removeUserCredentialFromLocalStorag() {
    _secureLocalStorage.deleteValue(key: _localStorage.userId);
    _secureLocalStorage.deleteValue(key: _secureLocalStorage.token);
  }

  void storeUserCredentials(AuthResponse response) {
    _secureLocalStorage.storeStringValue(
      key: _localStorage.userId,
      value: response.user?.id ?? "",
    );
    _secureLocalStorage.storeStringValue(
      key: _secureLocalStorage.token,
      value: response.session?.accessToken ?? "",
    );
  }

  FutureOr<void> _changePasswordEvent(
      ChangePasswordEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final bool response = await supabase
        .rpc('verify_user_password', params: {"password": event.oldPassword});

    if (response) {
      if (event.oldPassword == event.newPassword) {
        emit(AuthInitial());
        emit(AuthError(error: AppStrings.oldAndNewPasswordSameErrorMessage));

        return;
      }

      supabase.auth.updateUser(UserAttributes(password: event.newPassword));
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
      emit(AuthError(error: AppStrings.incorrectOldPassword));
    }
  }
}
