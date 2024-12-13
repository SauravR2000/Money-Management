import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/auth/presentation/verification_screen/verification_screen_body.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: const VerificationScreenBody(),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: Text(
        AppStrings.verification,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}
