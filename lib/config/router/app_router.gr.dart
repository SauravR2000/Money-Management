// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/cupertino.dart' as _i8;
import 'package:money_management_app/features/auth/presentation/login_screen/login_screen.dart'
    as _i2;
import 'package:money_management_app/features/auth/presentation/signup_screen/signup_screen.dart'
    as _i6;
import 'package:money_management_app/features/onboarding/ui/onboarding_screen.dart'
    as _i3;
import 'package:money_management_app/features/pincode/ui/confirm_pincode_screen.dart'
    as _i1;
import 'package:money_management_app/features/pincode/ui/pin_code_widget.dart'
    as _i4;
import 'package:money_management_app/features/pincode/ui/pincode_screen.dart'
    as _i5;

/// generated route for
/// [_i1.ConfirmPincodeScreen]
class ConfirmPincodeRoute extends _i7.PageRouteInfo<void> {
  const ConfirmPincodeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ConfirmPincodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfirmPincodeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.ConfirmPincodeScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
/// [_i2.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i7.PageInfo page = _i7.PageInfo(
  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginScreen();
      return const _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.OnboardingScreen]
class OnboardingRoute extends _i7.PageRouteInfo<void> {
  const OnboardingRoute({List<_i7.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i4.PinCodeWidget]
class PinCodeWidget extends _i7.PageRouteInfo<PinCodeWidgetArgs> {
  PinCodeWidget({
    _i8.Key? key,
    required String screenTitle,
    required _i4.Destination destination,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          PinCodeWidget.name,
          args: PinCodeWidgetArgs(
            key: key,
            screenTitle: screenTitle,
            destination: destination,
          ),
          initialChildren: children,
        );

  static const String name = 'PinCodeWidget';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PinCodeWidgetArgs>();
      return _i4.PinCodeWidget(
        key: args.key,
        screenTitle: args.screenTitle,
        destination: args.destination,
      );
    },
  );
}

class PinCodeWidgetArgs {
  const PinCodeWidgetArgs({
    this.key,
    required this.screenTitle,
    required this.destination,
  });

  final _i8.Key? key;

  final String screenTitle;

  final _i4.Destination destination;

  @override
  String toString() {
    return 'PinCodeWidgetArgs{key: $key, screenTitle: $screenTitle, destination: $destination}';
  }
}

/// generated route for
/// [_i5.PincodeScreen]
class PincodeRoute extends _i7.PageRouteInfo<void> {
  const PincodeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          PincodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PincodeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.PincodeScreen();
    },
  );
}

/// generated route for
/// [_i6.SignupScreen]
class SignupRoute extends _i7.PageRouteInfo<void> {
  const SignupRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SignupScreen();
    },
  );
}
