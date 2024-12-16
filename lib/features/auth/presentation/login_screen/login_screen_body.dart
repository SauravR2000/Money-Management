import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/custom_text_from_field.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/enums.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return UnfocusScreenWidget(
      child: screenPadding(
        child: ListView(
          shrinkWrap: true,
          children: [
            gap(value: 56),
            CustomTextFormField(
              controller: _emailController,
              labelText: AppStrings.email,
              errorCheckType: ErrorCheckType.email,
            ),
            gap(value: 24),
            CustomTextFormField(
              controller: _passwordController,
              labelText: AppStrings.password,
              isPassword: true,
              errorCheckType: ErrorCheckType.password,
            ),
            gap(value: 40),
            CustomButton(
              onPressed: () {
                // TODO: REMOVE THIS CODE
                context.router.push(const PincodeRoute());
              },
              text: AppStrings.login,
            ),
            gap(value: 33),
            Center(
              child: Text(
                AppStrings.forgotPassword,
                style: textTheme.headlineMedium!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            gap(value: 38),
            Center(
              child: RichText(
                text: TextSpan(
                  style: textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: "${AppStrings.dontHaveAnAccount} ",
                      style: textTheme.bodyMedium!
                          .copyWith(color: AppColors.hintTextColor),
                    ),
                    TextSpan(
                      text: AppStrings.signUp,
                      style: textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.router.push(
                            const SignupRoute(),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
