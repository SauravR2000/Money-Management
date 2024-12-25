import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  final String userImageUrl;
  final String? incomeAmount;
  final String? expenseAmount;
  final String? totalAmount;

  const HomeScreen({
    super.key,
    required this.userImageUrl,
    this.incomeAmount,
    this.expenseAmount,
    this.totalAmount,
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
          onPressed: () {},
          icon: widget.userImageUrl.isNotEmpty
              ? Image.network(widget.userImageUrl)
              : ClipOval(
                  child: Image.asset(
                    'assets/images/user.webp',
                  ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                    'Rs.${widget.totalAmount ?? '0'}',
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
                                    'Rs.${widget.incomeAmount ?? '0'}',
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
                                    'Rs.${widget.expenseAmount ?? '0'}',
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
          SingleChildScrollView(
            child: SfCartesianChart(
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
            ),
          ),
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
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: TextButton(
                  child: Text(
                    'See All',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
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
        ],
      ),
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
