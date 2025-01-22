import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/helper/format_date_time.dart';
import 'package:money_management_app/main.dart';
import 'package:money_management_app/shared_widgets/dotted_divider.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/utils/constants/colors.dart';
import 'package:money_management_app/utils/constants/strings.dart';

class TransactionDetailBody extends StatefulWidget {
  final TransactionModel transaction;
  const TransactionDetailBody({
    super.key,
    required this.transaction,
  });

  @override
  State<TransactionDetailBody> createState() => _TransactionDetailBodyState();
}

class _TransactionDetailBodyState extends State<TransactionDetailBody> {
  late bool isExpense;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    isExpense = widget.transaction.isExpense;

    if (widget.transaction.attachment.isNotEmpty) {
      imageUrl =
          supabase.storage.from('').getPublicUrl(widget.transaction.attachment);
    }

    log("image url = $imageUrl");
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: transactionAmountAndDateTime(context),
                  ),
                  gap(value: 18),
                ],
              ),
              Positioned(
                bottom: -5,
                right: deviceWidth / 22.5,
                child: transactionDetailContainer(deviceWidth, context),
              )
            ],
          ),
        ),
        gap(value: 50),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            child: screenPadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DottedDivider(
                    height: 2.3,
                    color: AppColors.hintTextColor,
                  ),
                  gap(value: 14),
                  Text(
                    AppStrings.description,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.hintTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                  gap(value: 10),
                  Text(
                    widget.transaction.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  gap(value: 15),
                  Text(
                    AppStrings.attachment,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.hintTextColor,
                        fontWeight: FontWeight.w600),
                  ),
                  gap(value: 10),
                  // widget.transaction.attachment.isEmpty
                  imageUrl == null
                      ? Text(AppStrings.noAttachmentFound)
                      : SizedBox(
                          height: 500,
                          width: double.maxFinite,
                          child: Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Container transactionAmountAndDateTime(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 30,
        horizontal: 20,
      ),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: isExpense ? AppColors.expenseColor : AppColors.incomeColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          Text(
            "Rs. ${widget.transaction.amount}",
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 48,
                ),
          ),
          gap(value: 12),
          Text(
            formatDateTime(dateTime: widget.transaction.createdAt),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
    );
  }

  Container transactionDetailContainer(
      double deviceWidth, BuildContext context) {
    return Container(
      width: deviceWidth / 1.1,
      height: 98,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          transactionDataWidget(
            context: context,
            title: AppStrings.type,
            value: widget.transaction.isExpense
                ? AppStrings.expense
                : AppStrings.income,
          ),
          transactionDataWidget(
            context: context,
            title: AppStrings.category,
            value: widget.transaction.category,
          ),
          transactionDataWidget(
            context: context,
            title: AppStrings.wallet,
            value: widget.transaction.wallet,
          ),
        ],
      ),
    );
  }

  Expanded transactionDataWidget({
    required BuildContext context,
    required String title,
    required String value,
  }) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColors.hintTextColor),
          ),
          gap(value: 9),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
