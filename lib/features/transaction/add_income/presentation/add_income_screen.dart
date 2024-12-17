import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/transaction/transaction_screen_UI.dart';
import 'package:money_management_app/utils/constants/enums.dart';

@RoutePage()
class AddIncomeScreen extends StatelessWidget {
  const AddIncomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TransactionScreenUi(transactionType: TransactionType.income);
  }
}
