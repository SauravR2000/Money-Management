import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/transaction/cubit/drop_down/drop_down_cubit_cubit.dart';
import 'package:money_management_app/features/transaction/widget/add_attachment.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/borderless_textfield.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/custom_drop_down.dart';
import 'package:money_management_app/shared_widgets/custom_text_from_field.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/enums.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class TransactionScreenBody extends StatefulWidget {
  final TransactionType transactionType;
  const TransactionScreenBody({super.key, required this.transactionType});

  @override
  State<TransactionScreenBody> createState() => _TransactionScreenBodyState();
}

class _TransactionScreenBodyState extends State<TransactionScreenBody> {
  late TextEditingController _amountController;
  late TextEditingController _descriptionController;

  late DropDownCubit _categoryDropDownCubit;
  late DropDownCubit _walletDropDownCubit;

  final List<String> _dropdownValues = ["g", "Two", "Three", "Four", "Five"];
  final List<String> _walletOptions = ["Esewa", "Bank", "Cash", "Fonepay"];

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
    _categoryDropDownCubit = getIt<DropDownCubit>();
    _walletDropDownCubit = getIt<DropDownCubit>();
  }

  @override
  void dispose() {
    super.dispose();

    _amountController.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusScreenWidget(
      child: Column(
        children: [
          gap(value: 59),
          enterAmount(context),
          gap(value: 16),
          transactionDetail(),
        ],
      ),
    );
  }

  Expanded transactionDetail() {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: [
                categoryDropdown(
                  bloc: _categoryDropDownCubit,
                  dropdownValues: _dropdownValues,
                  hintText: AppStrings.category,
                ),
                gap(value: 20),
                CustomTextFormField(
                  controller: _descriptionController,
                  labelText: AppStrings.description,
                  hintColor: Colors.black,
                  hintFontSize: 16,
                ),
                gap(value: 20),
                categoryDropdown(
                  bloc: _walletDropDownCubit,
                  dropdownValues: _walletOptions,
                  hintText: AppStrings.wallet,
                ),
                gap(value: 20),
                // DottedBorder(
                //   borderType: BorderType.RRect,
                //   padding: EdgeInsets.all(15),
                //   color: AppColors.primaryColor,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image.asset("assets/images/attachment.png"),
                //       gap(value: 15),
                //       Text(AppStrings.addAttachment)
                //     ],
                //   ),
                // ),

                AddAttachmentWidget(),
                gap(value: 30),
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

  Padding enterAmount(BuildContext context) {
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
                  controller: _amountController,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
