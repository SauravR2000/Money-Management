import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:money_management_app/features/auth/bloc/check_box_bloc/check_box_bloc.dart';
import 'package:money_management_app/features/auth/presentation/login_screen/login_screen.dart';
import 'package:money_management_app/features/auth/presentation/login_with_google_widget.dart';
import 'package:money_management_app/features/auth/presentation/signup_screen/signup_screen.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/custom_text_from_field.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/enums.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class SignupScreenBody extends StatefulWidget {
  const SignupScreenBody({super.key});

  @override
  State<SignupScreenBody> createState() => _SignupScreenBodyState();
}

class _SignupScreenBodyState extends State<SignupScreenBody> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late CheckBoxBloc _checkBoxBloc;
  final _formKey = GlobalKey<FormState>();

  late AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _checkBoxBloc = CheckBoxBloc();

    _authBloc = getIt<AuthBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    _checkBoxBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: UnfocusScreenWidget(
        child: screenPadding(
          child: ListView(
            shrinkWrap: true,
            children: [
              gap(value: 56),
              CustomTextFormField(
                controller: _nameController,
                labelText: AppStrings.name,
                errorCheckType: ErrorCheckType.name,
              ),
              gap(value: 24),
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
              gap(value: 17),
              checkboxAndTermsAndCondition(textTheme, context),
              gap(value: 27),
              signUpButton(),
              gap(value: 12),
              Center(
                child: Text(
                  AppStrings.orWith,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.hintTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              gap(value: 12),
              // loginWithGoogle(textTheme),
              const LoginWithGoogleWidget(),
              gap(value: 19),
              Center(
                child: RichText(
                  text: TextSpan(
                    style: textTheme.bodyMedium,
                    children: [
                      TextSpan(
                        text: "${AppStrings.alreadyHaveAnAccount} ",
                        style: textTheme.bodyMedium!
                            .copyWith(color: AppColors.hintTextColor),
                      ),
                      TextSpan(
                        text: AppStrings.login,
                        style: textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget signUpButton() {
    return BlocBuilder<CheckBoxBloc, CheckBoxState>(
      bloc: _checkBoxBloc,
      builder: (context, checkBoxState) {
        return BlocConsumer<AuthBloc, AuthState>(
          bloc: _authBloc,
          listener: (context, state) {
            if (state is AuthSuccess) {
              context.router.popForced();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.signupSuccess),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, authBlocState) {
            return CustomButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _authBloc.add(
                    SignupEvent(
                      email: _emailController.text,
                      userName: _nameController.text,
                      password: _passwordController.text,
                    ),
                  );
                }
              },
              isEnabled: _checkBoxBloc.checkboxValue,
              text: AppStrings.signUp,
              isLoading: authBlocState is AuthLoading,
            );
          },
        );
      },
    );
  }

  Row checkboxAndTermsAndCondition(TextTheme textTheme, BuildContext context) {
    return Row(
      children: [
        BlocBuilder<CheckBoxBloc, CheckBoxState>(
          bloc: _checkBoxBloc,
          builder: (context, state) {
            return Checkbox(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              activeColor: AppColors.primaryColor,
              checkColor: Colors.white,
              side: BorderSide(
                color: AppColors.primaryColor,
                width: 1.0, // Border width
              ),
              value: _checkBoxBloc.checkboxValue,
              onChanged: (value) {
                _checkBoxBloc
                    .add(ToggleCheckbox(checkBoxValue: value ?? false));
              },
            );
          },
        ),
        gap(value: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: AppStrings.signupAggreement,
                  style: textTheme.bodyMedium!
                      .copyWith(color: AppColors.hintTextColor),
                ),
                TextSpan(
                  text: " ${AppStrings.termsAndCondition}",
                  style: textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ));
                    },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
