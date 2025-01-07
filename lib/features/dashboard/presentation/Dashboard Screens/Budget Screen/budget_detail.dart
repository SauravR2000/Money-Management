import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';

@RoutePage()
class BudgetDetail extends StatefulWidget {
  final String category;
  final String amount;

  const BudgetDetail({super.key, required this.category, required this.amount});

  @override
  State<BudgetDetail> createState() => _BudgetDetailState();
}

class _BudgetDetailState extends State<BudgetDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete),
          )
        ],
        title: Text(
          "Budget Detail",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 70),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 80,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 238, 229, 255),
                ),
                child: Center(
                  child: Text(
                    widget.category,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                  ),
                ),
              ),
              gap(value: 40),
              Text(
                'Remaining',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 28),
              ),
              gap(value: 20),
              Text(
                "Rs.${widget.amount}",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 60),
              ),
              gap(value: 400),
              SizedBox(
                height: 56,
                width: 323,
                child: ElevatedButton(
                  style: Theme.of(context).elevatedButtonTheme.style,
                  onPressed: () {
                    // TODO:- Navigate to add budget screen and populate the data
                  },
                  child: Text(
                    'Edit',
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
