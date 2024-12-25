import 'package:flutter/material.dart';
import 'package:money_management_app/shared_widgets/borderless_textfield.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/strings.dart';

Padding enterAmount(
    BuildContext context, TextEditingController amountController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.howMuch,
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: AppColors.lightGreyColor),
        ),
        Row(
          children: [
            Text(
              AppStrings.rs,
              style: TextStyle(color: Colors.white, fontSize: 64),
            ),
            Expanded(
              child: BorderlessTextField(
                controller: amountController,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
