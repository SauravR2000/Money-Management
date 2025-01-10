import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/core/services/notification_service.dart';
import 'package:money_management_app/dummy_data.dart';
import 'package:money_management_app/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Home%20Screen/cubit/home_screen_cubit.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Home%20Screen/data/chart_data_model.dart';
import 'package:money_management_app/features/global_bloc/global_bloc.dart';
import 'package:money_management_app/features/transaction/data/model/transaction_model.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/profile_image.dart';
import 'package:money_management_app/shared_widgets/screen_padding.dart';
import 'package:money_management_app/shared_widgets/transaction_listing_item.dart';
import 'package:money_management_app/utils/constants/strings.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  final DashboardCubit dashboardCubit;

  const HomeScreen({
    super.key,
    required this.dashboardCubit,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String dropDownValue = 'January';
  var items = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  late HomeScreenCubit totalTransactionCubit;
  late HomeScreenCubit allTransactionCubit;

  @override
  void initState() {
    super.initState();
    getIt<GlobalBloc>().add(GetUserDetail());

    totalTransactionCubit = getIt<HomeScreenCubit>();
    allTransactionCubit = getIt<HomeScreenCubit>();

    apiCall();
  }

  apiCall() {
    totalTransactionCubit.getAccountBalance();
    allTransactionCubit.getAllTransactions(limit: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 246, 229),
        leading: IconButton(
          onPressed: () {
            widget.dashboardCubit.changePage(3);
          },
          icon: BlocBuilder<GlobalBloc, GlobalState>(
            bloc: getIt<GlobalBloc>(),
            builder: (context, state) {
              String imageUrl = getIt<GlobalBloc>().profileImage ?? dummyImage;

              log("image url == $imageUrl");

              return profileImage(
                context: context,
                imageUrl: imageUrl,
              );
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // NotificationService().showScheduleNotification(
              //   title: "gg ezz appp",
              //   body: "bello hello",
              //   schedulesTime: Duration(seconds: 10),
              // );
            },
            icon: Icon(
              Icons.notifications_rounded,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          apiCall();
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              accountBalance(context),

              gap(value: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 10),
                    child: Text(
                      'Recent Transactions',
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, top: 10),
                    child: TextButton(
                      child: Text(
                        'See All',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      onPressed: () {
                        widget.dashboardCubit.changePage(1);
                      },
                    ),
                  ),
                ],
              ),
              gap(value: 15),
              BlocBuilder<HomeScreenCubit, HomeScreenState>(
                bloc: allTransactionCubit,
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AllTransactionsSuccessState) {
                    List<TransactionModel> transactions = state.transactions;

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) => gap(value: 10),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        TransactionModel transaction = transactions[index];

                        return GestureDetector(
                          onTap: () {
                            context.router.push(
                              TransactionDetailRoute(
                                transactionModel: transaction,
                              ),
                            );
                          },
                          child: TransactionListingItemUi(
                              transaction: transaction),
                        );
                      },
                    );
                  } else if (state is ErrorState) {
                    return screenPadding(child: Text(state.errorMessage));
                  } else {
                    return screenPadding(
                      child: Text(AppStrings.somethingWentWrong),
                    );
                  }
                },
              ),

              //for bottom tab padding
              gap(value: 200),
            ],
          ),
        ),
      ),
    );
  }

  Widget chart({required double income, required double expense}) {
    List<ChartData> chartData = (income == 0 && expense == 0)
        ? [ChartData('No Data', 1, Colors.grey)] // Single grey slice
        : [
            ChartData('Income', income, Colors.green),
            ChartData('Expense', expense, Colors.red),
          ];

    return SfCircularChart(
      title: ChartTitle(text: 'Income vs Expense'),
      legend: Legend(isVisible: true, position: LegendPosition.bottom),
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.label,
          yValueMapper: (ChartData data, _) => data.value,
          pointColorMapper: (ChartData data, _) => data.color,
          dataLabelSettings: (income == 0 && expense == 0)
              ? const DataLabelSettings(isVisible: false) // Hide labels
              : const DataLabelSettings(
                  isVisible: true,
                  color: Colors.white,
                  labelPosition: ChartDataLabelPosition.outside,
                ),
          explode: true, // Enables exploding on selection
        ),
      ],
    );
  }

  Widget accountBalance(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      bloc: totalTransactionCubit,
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BalanceSuccessState) {
          double totalAmount = state.homeScreenTransactionModel.balance;
          double totalIncome = state.homeScreenTransactionModel.totalIncome;
          double totalExpense = state.homeScreenTransactionModel.totalExpense;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 255, 246, 229),
                      Color.fromARGB(255, 255, 249, 235)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Account Balance',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 18,
                                color: Colors.black54),
                      ),
                      Text(
                        'Rs.$totalAmount',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(fontSize: 30),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                context.router.push(AddIncomeRoute());
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                // height: 80,
                                // width: 164,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 0, 168, 107),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/income.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Income',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            'Rs.$totalIncome',
                                            maxLines: 3,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          gap(value: 10),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                context.router.push(AddExpenseRoute());
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                // height: 80,
                                // width: 164,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 253, 61, 74),
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/expense.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Expense',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineMedium!
                                                .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          Text(
                                            'Rs.$totalExpense',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      gap(value: 15),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Spend Frequency',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              SizedBox(height: 15),
              chart(income: totalIncome, expense: totalExpense),
            ],
          );
        } else {
          return Text("Something went wrong");
        }
      },
    );
  }
}

class ExpenseData {
  String year;
  double sales;
  ExpenseData(this.year, this.sales);
}

class RecentTransactions {
  String iconName;
  String title;
  String amount;
  RecentTransactions(this.iconName, this.title, this.amount);
}
