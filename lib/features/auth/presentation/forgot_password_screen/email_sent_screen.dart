import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/helper/get_text_theme.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class EmailSentScreen extends StatelessWidget {
  const EmailSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = getTextTheme(context: context);

    return Scaffold(
      body: SafeArea(
        child: screenPadding(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              gap(value: 62),
              Image.asset("assets/images/email_sent.png"),
              gap(value: 18),
              Text(
                AppStrings.emailOnTheWay,
                style: textTheme.headlineLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              gap(value: 24),
              Text(
                AppStrings.checkEmailAndFollowInstruction,
                style: textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: AppStrings.backToLogin,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
