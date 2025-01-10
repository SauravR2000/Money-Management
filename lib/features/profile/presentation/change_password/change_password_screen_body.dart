import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/custom_snackbar.dart';
import 'package:money_management_app/shared_widgets/custom_text_from_field.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/enums.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class ChangePasswordScreenBody extends StatefulWidget {
  const ChangePasswordScreenBody({super.key});

  @override
  State<ChangePasswordScreenBody> createState() =>
      _ChangePasswordScreenBodyState();
}

class _ChangePasswordScreenBodyState extends State<ChangePasswordScreenBody> {
  late TextEditingController _oldPassword;
  late TextEditingController _newPassword;

  late AuthBloc _authBloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _oldPassword = TextEditingController();
    _newPassword = TextEditingController();

    _authBloc = getIt<AuthBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: UnfocusScreenWidget(
          child: screenPadding(
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _oldPassword,
                  labelText: AppStrings.password,
                  isPassword: true,
                  errorCheckType: ErrorCheckType.password,
                ),
                gap(value: 20),
                CustomTextFormField(
                  controller: _newPassword,
                  labelText: AppStrings.newPassword,
                  isPassword: true,
                  errorCheckType: ErrorCheckType.password,
                ),
                gap(value: 45),
                SizedBox(
                  width: double.maxFinite,
                  child: BlocConsumer<AuthBloc, AuthState>(
                    bloc: _authBloc,
                    listener: (context, state) {
                      if (state is AuthSuccess) {
                        showFlutterToast(
                          message: AppStrings.passwordChangeSuccess,
                          isError: false,
                        );
                        context.router.popForced();
                      } else if (state is AuthError) {
                        showFlutterToast(
                          message: state.error,
                          isError: true,
                        );
                      }
                    },
                    builder: (context, state) {
                      return CustomButton(
                        text: AppStrings.changePassword,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _authBloc.add(
                              ChangePasswordEvent(
                                oldPassword: _oldPassword.text,
                                newPassword: _newPassword.text,
                              ),
                            );
                          }
                        },
                        isLoading: state is AuthLoading,
                        isEnabled: state is! AuthLoading,
                      );
                    },
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
