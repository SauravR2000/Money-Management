import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.privacyPolicy),
      ),
      body: SafeArea(
        child: screenPadding(
          child: Text(AppStrings.privacyPolicyMessage),
        ),
      ),
    );
  }
}
