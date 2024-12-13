import 'package:flutter/material.dart';
import 'package:money_management_app/helper/email_validation.dart';
import 'package:money_management_app/helper/password_validation.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/enums.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Key? formKey;
  final String? hintText;
  final bool isPassword;
  final bool showError;
  final TextInputType textInputType;
  final ErrorCheckType? errorCheckType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.isPassword = false,
    this.formKey,
    this.showError = false,
    this.textInputType = TextInputType.text,
    this.errorCheckType,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;
  late bool showError;

  @override
  void initState() {
    super.initState();
    obscureText = widget.isPassword;
    showError = widget.showError;
  }

  String? getErrorMessage() {
    if (widget.errorCheckType != null) {
      switch (widget.errorCheckType) {
        case ErrorCheckType.email:
          return validateEmail(widget.controller.text);

        case ErrorCheckType.password:
          return validatePassword(widget.controller.text);

        default:
          return null;
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabledBorderColor = Colors.grey[300]!;

    return Form(
      key: widget.formKey,
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF6FAF9),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontSize: 12,
            color: AppColors.hintTextColor,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.primaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.grey[200]!,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Rounded border when focused
            borderSide: BorderSide(
              color: AppColors.primaryColor, // Change border color when focused
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8.0), // Rounded border when enabled
            borderSide: BorderSide(
              color: enabledBorderColor,
            ),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () => setState(() {
                    obscureText = !obscureText;
                  }),
                  icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off),
                )
              : null,
          errorText: showError ? getErrorMessage() : null,
        ),
        validator: (value) => showError ? getErrorMessage() : null,
      ),
      onChanged: () {
        setState(() {
          showError = true;
        });
      },
    );
  }
}
