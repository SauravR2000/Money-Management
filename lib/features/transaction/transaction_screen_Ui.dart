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
    return WillPopScope(
      onWillPop: () {
        return _onWillPop(context: context);
      },
      child: Scaffold(
        backgroundColor: color,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
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
      ),
    );
  }

  Future<bool> _onWillPop({required BuildContext context}) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(AppStrings.areYouSure),
            content: Text(AppStrings.goingBackWillDiscardChanges),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
