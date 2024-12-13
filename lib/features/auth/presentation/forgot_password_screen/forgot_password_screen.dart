import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/auth/presentation/forgot_password_screen/forgot_password_screen_body.dart';
import 'package:money_management_app/helper/get_text_theme.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = getTextTheme(context: context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.forgotPassword,
          style: textTheme.headlineLarge,
        ),
      ),
      body: const ForgotPasswordScreenBody(),
    );
  }
}
