import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
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

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  late AuthBloc _authBloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _authBloc = getIt<AuthBloc>();
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

    return Form(
      key: _formKey,
      child: UnfocusScreenWidget(
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
              loginButton(),
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
          ),
        ),
      ),
    );
  }

  BlocConsumer<AuthBloc, AuthState> loginButton() {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AuthSuccess) {
          context.router.replaceAll([PincodeRoute()]);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppStrings.signinSuccess),
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
      builder: (context, state) {
        return CustomButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _authBloc.add(
                LoginEvent(
                  email: _emailController.text,
                  password: _passwordController.text,
                ),
              );
            }
          },
          text: AppStrings.login,
          isLoading: state is AuthLoading,
        );
      },
    );
  }
}
