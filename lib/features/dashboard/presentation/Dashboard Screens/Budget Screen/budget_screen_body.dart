import 'package:flutter/material.dart';

class BudgetScreenBody extends StatefulWidget {
  const BudgetScreenBody({super.key});

  @override
  State<BudgetScreenBody> createState() => _BudgetScreenBodyState();
}

class _BudgetScreenBodyState extends State<BudgetScreenBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
      ),
    );
  }
}
