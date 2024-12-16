import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gotrue/src/types/auth_response.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/core/network/auth_service.dart';
import 'package:money_management_app/core/network/execute_api_call.dart';
import 'package:money_management_app/core/storage/local_storage.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';

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

  void storeUserCredentials(AuthResponse response) {
    log("local storage");
    _localStorage.storeStringValue(
      key: _localStorage.userId,
      value: response.user?.id ?? "",
    );
    log("secure storage");
    _secureLocalStorage.storeStringValue(
      key: _secureLocalStorage.token,
      value: response.session?.accessToken ?? "",
    );
  }
}
