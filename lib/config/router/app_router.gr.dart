// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:money_management_app/features/auth/presentation/login_screen/login_screen.dart'
    as _i1;
import 'package:money_management_app/features/auth/presentation/signup_screen/signup_screen.dart'
    as _i4;
import 'package:money_management_app/features/onboarding/ui/onboarding.dart'
    as _i2;
import 'package:money_management_app/features/pincode/ui/pincode_screen.dart'
    as _i3;

/// generated route for
/// [_i1.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.LoginScreen();
    },
  );
}

/// generated route for
/// [_i2.Onboarding]
class Onboarding extends _i5.PageRouteInfo<void> {
  const Onboarding({List<_i5.PageRouteInfo>? children})
      : super(
          Onboarding.name,
          initialChildren: children,
        );

  static const String name = 'Onboarding';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.Onboarding();
    },
  );
}

/// generated route for
/// [_i3.PincodeScreen]
class PincodeRoute extends _i5.PageRouteInfo<void> {
  const PincodeRoute({List<_i5.PageRouteInfo>? children})
      : super(
          PincodeRoute.name,
          initialChildren: children,
        );

  static const String name = 'PincodeRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.PincodeScreen();
    },
  );
}

/// generated route for
/// [_i4.SignupScreen]
class SignupRoute extends _i5.PageRouteInfo<void> {
  const SignupRoute({List<_i5.PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SignupScreen();
    },
  );
}
