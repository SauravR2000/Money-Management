import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/dummy_data.dart';
import 'package:money_management_app/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Home%20Screen/cubit/home_screen_cubit.dart';
import 'package:money_management_app/features/global_bloc/global_bloc.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/profile_image.dart';
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

  late HomeScreenCubit homeScreenCubit;

  @override
  void initState() {
    super.initState();
    getIt<GlobalBloc>().add(GetUserDetail());

    homeScreenCubit = getIt<HomeScreenCubit>();

    homeScreenCubit.getAccountBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: DropdownButton(
          menuMaxHeight: 300,
          value: dropDownValue,
          items: items
              .map(
                (String item) => DropdownMenuItem(
                  value: item,
                  child:
                      Text(item, style: Theme.of(context).textTheme.bodyMedium),
                ),
              )
              .toList(),
          onChanged: (String? value) {
            setState(
              () {
                dropDownValue = value!;
              },
            );
          },
        ),
        backgroundColor: Color.fromARGB(255, 255, 246, 229),
        leading: IconButton(
          onPressed: () {
            widget.dashboardCubit.changePage(3);
          },
          icon: BlocBuilder<GlobalBloc, GlobalState>(
            bloc: getIt<GlobalBloc>(),
            builder: (context, state) {
              String imageUrl = getIt<GlobalBloc>().profileImage ?? dummyImage;

              return profileImage(
                context: context,
                imageUrl: imageUrl,
              );
            },
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_rounded,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            accountBalance(context),
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
            chart(),
            gap(value: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    'Recent Transactions',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
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
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    onPressed: () {},
                  ),
                ),
                Row(children: [])
              ],
            ),
            //for bottom tab padding
            gap(value: 200),
          ],
        ),
      ),
    );
  }

  SfCartesianChart chart() {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      // primaryYAxis: NumericAxis(
      //   minimum: 0,
      //   maximum: 20,
      // ),
      series: <LineSeries<ExpenseData, String>>[
        LineSeries<ExpenseData, String>(
            // Bind data source
            dataSource: <ExpenseData>[
              ExpenseData('Jan', 35),
              ExpenseData('Feb', 28),
              ExpenseData('Mar', 34),
              ExpenseData('Apr', 32),
              ExpenseData('May', 40)
            ],
            xValueMapper: (ExpenseData sales, _) => sales.year,
            yValueMapper: (ExpenseData sales, _) => sales.sales)
      ],
    );
  }

  Widget accountBalance(BuildContext context) {
    return BlocBuilder<HomeScreenCubit, HomeScreenState>(
      bloc: homeScreenCubit,
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BalanceSuccessState) {
          double totalAmount = state.homeScreenTransactionModel.balance;
          double totalIncome = state.homeScreenTransactionModel.totalIncome;
          double totalExpense = state.homeScreenTransactionModel.totalExpense;

          return Container(
            height: 220,
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
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
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
                      InkWell(
                        onTap: () {
                          context.router.push(AddIncomeRoute());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 80,
                          width: 164,
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.router.push(AddExpenseRoute());
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 80,
                          width: 164,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 253, 61, 74),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/expense.png',
                                height: 40,
                                width: 40,
                              ),
                              SizedBox(width: 10),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        .headlineLarge!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
