import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';
import 'package:money_management_app/features/transaction/bloc/transaction_bloc.dart';
import 'package:money_management_app/features/transaction/cubit/add_attachment/add_attachment_cubit.dart';
import 'package:money_management_app/features/transaction/cubit/drop_down/drop_down_cubit_cubit.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/features/transaction/widget/add_attachment.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/borderless_textfield.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/custom_drop_down.dart';
import 'package:money_management_app/shared_widgets/custom_snackbar.dart';
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
  late AddAttachmentCubit _addAttachmentCubit;

  late List<String> _category;
  late TransactionBloc _transactionBloc;
  final List<String> _walletOptions = ["Esewa", "Bank", "Cash", "Fonepay"];

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController();
    _descriptionController = TextEditingController();
    _categoryDropDownCubit = getIt<DropDownCubit>();
    _walletDropDownCubit = getIt<DropDownCubit>();
    _addAttachmentCubit = getIt<AddAttachmentCubit>();

    _transactionBloc = getIt<TransactionBloc>();

    initializeCategories();
  }

  initializeCategories() {
    _category = widget.transactionType == TransactionType.expense
        ? [
            "Food & Dining",
            "Transportation",
            "Housing",
            "Utilities",
            "Insurance",
            "Healthcare",
            "Debt Payments",
            "Entertainment",
            "Education",
            "Groceries",
            "Clothing",
            "Personal Care",
            "Savings",
            "Gifts & Donations",
            "Travel",
            "Fitness",
            "Subscriptions",
            "Childcare",
            "Miscellaneous"
          ]
        : [
            "Salary",
            "Business Income",
            "Freelance Income",
            "Investments",
            "Rental Income",
            "Dividends",
            "Interest Income",
            "Gifts",
            "Pension",
            "Grants",
            "Bonuses",
            "Royalties",
            "Capital Gains",
            "Tax Refunds",
            "Side Hustles",
            "Allowance",
            "Commission",
            "Savings Withdrawal",
            "Scholarships",
            "Other"
          ];
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

  Widget transactionDetail() {
    return BlocConsumer<TransactionBloc, TransactionState>(
      bloc: _transactionBloc,
      listener: (context, state) {
        if (state is TransactionSuccess) {
          _amountController.text = "";
          _categoryDropDownCubit.value = null;
          _descriptionController.text = "";
          _walletDropDownCubit.value = null;
          _addAttachmentCubit.image = null;

          customSuccessSnackBar(
            context: context,
            errorMessage: AppStrings.transactionAddedSuccessfully,
          );
        }
      },
      builder: (context, state) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  children: [
                    categoryDropdown(
                      bloc: _categoryDropDownCubit,
                      dropdownValues: _category,
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
                    AddAttachmentWidget(
                      addAttachmentCubit: _addAttachmentCubit,
                    ),
                    gap(value: 30),
                    SizedBox(
                      width: double.maxFinite,
                      child: CustomButton(
                        text: AppStrings.continueString,
                        onPressed: () {
                          _addTransaction(context);
                        },
                        isLoading: state is TransactionLoading,
                        isEnabled: state is! TransactionLoading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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

  void _addTransaction(BuildContext context) async {
    if (_amountController.text.isEmpty) {
      log("amoutn = ${_amountController.text}");
      customErrorSnackBar(
        context: context,
        errorMessage: AppStrings.amountCantBeEmpty,
      );
      return;
    }

    if (_categoryDropDownCubit.value?.isEmpty ?? true) {
      customErrorSnackBar(
        context: context,
        errorMessage: AppStrings.categoryCantBeEmpty,
      );
      return;
    }

    if (_walletDropDownCubit.value?.isEmpty ?? true) {
      customErrorSnackBar(
        context: context,
        errorMessage: AppStrings.walletCantBeEmpty,
      );
      return;
    }

    SecureLocalStorage secureLocalStorage = getIt<SecureLocalStorage>();
    String userId =
        await secureLocalStorage.getStringValue(key: secureLocalStorage.userId);

    _transactionBloc.add(
      AddTransaction(
        transaction: TransactionModel(
          userId: userId,
          category: _categoryDropDownCubit.value ?? "",
          description: _descriptionController.text,
          wallet: _walletDropDownCubit.value ?? "",
          attachment: "",
          isExpense: widget.transactionType == TransactionType.expense,
        ),
        imageFile: _addAttachmentCubit.image,
      ),
    );
  }
}
