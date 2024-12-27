import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/bloc/budget_bloc.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';

class BudgetScreenUi extends StatefulWidget {
  const BudgetScreenUi({super.key});

  @override
  State<BudgetScreenUi> createState() => _BudgetScreenUiState();
}

class _BudgetScreenUiState extends State<BudgetScreenUi> {
  late BudgetBloc _budgetBloc;

  @override
  void initState() {
    _budgetBloc = BudgetBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: UnfocusScreenWidget(
        child: Column(
          children: [
            gap(value: 50),
            Text(
              'Add calendar here',
              style: TextStyle(color: Colors.white),
            ),
            gap(value: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: BlocProvider(
                  create: (context) => _budgetBloc..add(DataLoadedEvent()),
                  child: BlocBuilder<BudgetBloc, BudgetState>(
                    builder: (context, state) {
                      log("budget state = $state");
                      log('budget list = ${_budgetBloc.budgetList}');
                      return Center(
                        child: _budgetBloc.budgetList.isEmpty
                            ? Text(
                                "You don't have a budget. \n Let's make one so you are in control.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                textAlign: TextAlign.center,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(20),
                                child: ListView.builder(
                                  itemCount: _budgetBloc.budgetList.length,
                                  itemBuilder: (context, index) {
                                    return budgetCards(
                                      _budgetBloc.budgetList[index].title,
                                      _budgetBloc.budgetList[index].amount,
                                    );
                                  },
                                ),
                              ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget budgetCards(String categoryTitle, int budgetAmount) {
    return Card(
      elevation: 50,
      shadowColor: Colors.black,
      child: SizedBox(
        width: 343,
        height: 187,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                categoryTitle,
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                budgetAmount.toString(),
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
