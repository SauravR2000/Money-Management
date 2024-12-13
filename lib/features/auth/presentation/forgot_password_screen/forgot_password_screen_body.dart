import 'package:flutter/material.dart';
import 'package:money_management_app/helper/get_text_theme.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/custom_text_from_field.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class ForgotPasswordScreenBody extends StatefulWidget {
  const ForgotPasswordScreenBody({super.key});

  @override
  State<ForgotPasswordScreenBody> createState() =>
      _ForgotPasswordScreenBodyState();
}

class _ForgotPasswordScreenBodyState extends State<ForgotPasswordScreenBody> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = getTextTheme(context: context);

    return UnfocusScreenWidget(
      child: screenPadding(
        child: ListView(
          children: [
            gap(value: 69),
            Text(
              AppStrings.dontWorry,
              style: textTheme.headlineLarge,
            ),
            Text(
              AppStrings.enterEmail,
              style: textTheme.headlineLarge,
            ),
            gap(value: 46),
            CustomTextFormField(
              controller: _emailController,
              labelText: AppStrings.email,
            ),
            gap(value: 32),
            CustomButton(
              text: AppStrings.continueString,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
