import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/profile/presentation/change_password/change_password_screen_body.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.changePassword),
      ),
      body: ChangePasswordScreenBody(),
    );
  }
}
