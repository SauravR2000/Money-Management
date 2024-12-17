import 'package:flutter/material.dart';
import 'package:money_management_app/utils/constants/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final bool isEnabled;
  final bool isLoading;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 17.0)),
      onPressed: isEnabled ? onPressed : null,
      child: isLoading
          ? CircularProgressIndicator()
          : Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
    );
  }
}
