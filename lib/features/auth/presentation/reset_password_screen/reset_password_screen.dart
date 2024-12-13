import 'package:flutter/material.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/custom_text_from_field.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _newPassword;
  late TextEditingController _confirmPassword;

  @override
  void initState() {
    super.initState();
    _newPassword = TextEditingController();
    _confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _newPassword.dispose();
    _confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.resetPassword),
      ),
      body: UnfocusScreenWidget(
        child: screenPadding(
          child: SingleChildScrollView(
            child: Column(
              children: [
                gap(value: 56),
                CustomTextFormField(
                  controller: _newPassword,
                  labelText: AppStrings.newPassword,
                ),
                gap(value: 24),
                CustomTextFormField(
                  controller: _confirmPassword,
                  labelText: AppStrings.retypeNewPassword,
                ),
                gap(value: 32),
                SizedBox(
                  width: double.maxFinite,
                  child: CustomButton(
                    text: AppStrings.continueString,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
