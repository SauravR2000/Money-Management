import 'package:flutter/material.dart';
import 'package:money_management_app/utils/constants/colors.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> dropdownValues;
  final String? valueSelected;
  final void Function(String?) onChanged;
  final String hintText;

  const CustomDropDown({
    super.key,
    required this.dropdownValues,
    required this.valueSelected,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(
          color: AppColors.borderColor,
          style: BorderStyle.solid,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          hint: Text(hintText),
          items: dropdownValues
              .map((value) => DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  ))
              .toList(),
          onChanged: (value) {
            onChanged(value);
          },
          isExpanded: false,
          value: valueSelected,
        ),
      ),
    );
  }
}
