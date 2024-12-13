import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/auth/presentation/signup_screen/signup_screen_body.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const SignupScreenBody(),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        AppStrings.signUp,
        style: Theme.of(context)
            .textTheme
            .headlineMedium!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
