import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/transaction/bloc/transaction_bloc.dart';
import 'package:money_management_app/features/transaction/cubit/add_attachment/add_attachment_cubit.dart';
import 'package:money_management_app/features/transaction/cubit/drop_down/drop_down_cubit_cubit.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/features/transaction/widget/add_attachment.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/main.dart';
import 'package:money_management_app/shared_widgets/amount_textfield.dart';
import 'package:money_management_app/shared_widgets/custom_button.dart';
import 'package:money_management_app/shared_widgets/custom_snackbar.dart';
import 'package:money_management_app/shared_widgets/custom_text_from_field.dart';
import 'package:money_management_app/shared_widgets/dropdown_category.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
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
          enterAmount(context, _amountController),
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

          // customSuccessSnackBar(
          //   context: context,
          //   errorMessage: AppStrings.transactionAddedSuccessfully,
          // );
          showFlutterToast(
            message: AppStrings.transactionAddedSuccessfully,
            isError: false,
          );

          context.router.popForced();
        } else if (state is TransactionError) {
          showFlutterToast(
            message: state.errorMessage,
            isError: true,
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

  void _addTransaction(BuildContext context) async {
    if (_amountController.text.isEmpty) {
      log("amoutn = ${_amountController.text}");
      // customErrorSnackBar(
      //   context: context,
      //   errorMessage: AppStrings.amountCantBeEmpty,
      // );

      showFlutterToast(
        message: AppStrings.amountCantBeEmpty,
        isError: true,
      );
      return;
    }

    if (_categoryDropDownCubit.value?.isEmpty ?? true) {
      // customErrorSnackBar(
      //   context: context,
      //   errorMessage: AppStrings.categoryCantBeEmpty,
      // );

      showFlutterToast(
        message: AppStrings.categoryCantBeEmpty,
        isError: true,
      );
      return;
    }

    if (_walletDropDownCubit.value?.isEmpty ?? true) {
      // customErrorSnackBar(
      //   context: context,
      //   errorMessage: AppStrings.walletCantBeEmpty,
      // );

      showFlutterToast(
        message: AppStrings.walletCantBeEmpty,
        isError: true,
      );
      return;
    }

    // SecureLocalStorage secureLocalStorage = getIt<SecureLocalStorage>();
    String userId = supabase.auth.currentUser?.id ?? "";

    _transactionBloc.add(
      AddTransaction(
        transaction: TransactionModel(
          userId: userId,
          category: _categoryDropDownCubit.value ?? "",
          description: _descriptionController.text,
          wallet: _walletDropDownCubit.value ?? "",
          attachment: "",
          isExpense: widget.transactionType == TransactionType.expense,
          amount: double.parse(_amountController.text),
          createdAt: DateTime.now(),
          budgetId: null,
        ),
        imageFile: _addAttachmentCubit.image,
        pdfFile: _addAttachmentCubit.pdf,
      ),
    );
  }
}
