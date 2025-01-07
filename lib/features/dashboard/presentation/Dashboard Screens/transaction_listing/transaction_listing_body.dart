import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Home%20Screen/cubit/home_screen_cubit.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/transaction_listing/cubit/transaction_listing_cubit.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/transaction_listing_item.dart';
import 'package:money_management_app/utils/constants/strings.dart';

// enum Months { All, Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec }

class TransactionListingBody extends StatefulWidget {
  const TransactionListingBody({super.key});

  @override
  State<TransactionListingBody> createState() => _TransactionListingBodyState();
}

class _TransactionListingBodyState extends State<TransactionListingBody> {
  late HomeScreenCubit _allTransactionCubit;
  late TransactionListingCubit _transactionListingCubit;

  List months = [
    "All",
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  @override
  void initState() {
    super.initState();

    _allTransactionCubit = getIt<HomeScreenCubit>();

    _allTransactionCubit.getAllTransactions();

    _transactionListingCubit = getIt<TransactionListingCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        monthsWidget(context),
        gap(value: 30),
        BlocBuilder<HomeScreenCubit, HomeScreenState>(
          bloc: _allTransactionCubit,
          builder: (context, state) {
            if (state is LoadingState) {
              return CircularProgressIndicator();
            } else if (state is AllTransactionsSuccessState) {
              List<TransactionModel> transactions = state.transactions;

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                separatorBuilder: (context, index) => gap(value: 10),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  TransactionModel transaction = transactions[index];

                  return GestureDetector(
                    onTap: () {
                      context.router.push(
                        TransactionDetailRoute(transactionModel: transaction),
                      );
                    },
                    child: TransactionListingItemUi(transaction: transaction),
                  );
                },
              );
            } else if (state is ErrorState) {
              return Text(state.errorMessage);
            } else {
              return Text(AppStrings.somethingWentWrong);
            }
          },
        ),
      ],
    );
  }

  Widget monthsWidget(BuildContext context) {
    return BlocBuilder<TransactionListingCubit, TransactionListingState>(
      bloc: _transactionListingCubit,
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 40,
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              Color textColor =
                  _transactionListingCubit.selectedMonthIndex == index
                      ? Colors.white
                      : Colors.black;

              Color containerColor =
                  _transactionListingCubit.selectedMonthIndex == index
                      ? Colors.grey
                      : Colors.transparent;

              return GestureDetector(
                onTap: () {
                  _transactionListingCubit.updateSelectedMonth(index: index);
                  _allTransactionCubit.getAllTransactions(month: index);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  child:
                      Text(months[index], style: TextStyle(color: textColor)),
                ),
              );
            },
            separatorBuilder: (context, index) => gap(value: 10),
            itemCount: months.length,
          ),
        );
      },
    );
  }
}
