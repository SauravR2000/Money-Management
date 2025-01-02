import 'package:flutter/material.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/helper/format_date_time.dart';
import 'package:money_management_app/utils/constants/colors.dart';

class TransactionListingItemUi extends StatelessWidget {
  const TransactionListingItemUi({
    super.key,
    required this.transaction,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    String incomeOrExpenseSymbol = transaction.isExpense ? "-" : "+";
    Color incomeOrExpenseColor =
        transaction.isExpense ? Colors.red : Colors.green;

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              transaction.category,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            Text(
              transaction.description,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.hintTextColor),
            ),
          ],
        ),
        Spacer(),
        SizedBox(
          width: 80,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$incomeOrExpenseSymbol ${transaction.amount.toString()}",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: incomeOrExpenseColor),
              ),
              Text(
                formatTime(
                  dateTime: transaction.createdAt,
                ),
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: AppColors.hintTextColor),
              ),
            ],
          ),
        )
      ],
    );
  }
}
