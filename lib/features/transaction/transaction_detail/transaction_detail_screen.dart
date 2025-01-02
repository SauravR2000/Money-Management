import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/features/transaction/transaction_detail/transaction_detail_body.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/strings.dart';

@RoutePage()
class TransactionDetailScreen extends StatelessWidget {
  final TransactionModel transactionModel;
  const TransactionDetailScreen({
    super.key,
    required this.transactionModel,
  });

  @override
  Widget build(BuildContext context) {
    bool isExpense = transactionModel.isExpense;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            isExpense ? AppColors.expenseColor : AppColors.incomeColor,
        centerTitle: true,
        title: Text(
          AppStrings.detailTransaction,
          style: Theme.of(context)
              .textTheme
              .headlineLarge!
              .copyWith(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Image.asset("assets/images/trash.png"),
          ),
          gap(value: 16),
        ],
      ),
      body: TransactionDetailBody(
        transaction: transactionModel,
      ),
    );
  }
}
