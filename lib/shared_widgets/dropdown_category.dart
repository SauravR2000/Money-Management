import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/transaction/cubit/drop_down/drop_down_cubit_cubit.dart';
import 'package:money_management_app/shared_widgets/custom_drop_down.dart';

Widget categoryDropdown({
  required DropDownCubit bloc,
  required List<String> dropdownValues,
  required String hintText,
}) {
  return BlocBuilder<DropDownCubit, DropDownState>(
    bloc: bloc,
    builder: (context, state) {
      var categorySelected = bloc.value;

      return CustomDropDown(
        dropdownValues: dropdownValues,
        valueSelected: categorySelected,
        onChanged: (value) {
          bloc.changeSelectedValue(
            selectedValue: value,
          );
        },
        hintText: hintText,
      );
    },
  );
}
