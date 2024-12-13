import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/auth/presentation/login_screen/login_screen_body.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const LoginScreenBody(),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        AppStrings.login,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
