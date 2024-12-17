import 'package:flutter/material.dart';
import 'package:money_management_app/features/transaction/transaction_screen_body.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/enums.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class TransactionScreenUi extends StatelessWidget {
  final TransactionType transactionType;

  const TransactionScreenUi({super.key, required this.transactionType});

  @override
  Widget build(BuildContext context) {
    bool isExpense = transactionType == TransactionType.expense;
    Color color = isExpense ? AppColors.expenseColor : AppColors.incomeColor;
    String title = isExpense ? AppStrings.expense : AppStrings.income;
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        centerTitle: true,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: TransactionScreenBody(transactionType: transactionType),
    );
  }
}
