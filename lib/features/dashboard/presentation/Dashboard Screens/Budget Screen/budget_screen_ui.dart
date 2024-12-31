import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/bloc/budget_bloc.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';

@RoutePage()
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _budgetBloc.budgetList.isEmpty
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
                                : Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: ListView.builder(
                                        itemCount:
                                            _budgetBloc.budgetList.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: budgetCards(
                                              _budgetBloc
                                                  .budgetList[index].title,
                                              _budgetBloc
                                                  .budgetList[index].amount,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                            gap(value: 20),
                            SizedBox(
                              height: 56,
                              width: 350,
                              child: ElevatedButton(
                                style:
                                    Theme.of(context).elevatedButtonTheme.style,
                                onPressed: () {
                                  context.router.push(BudgetRoute());
                                },
                                child: Text(
                                  'Create a Budget',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ),
                            gap(value: 50)
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget budgetCards(
      String categoryTitle, int budgetAmount /*, int remainingAmount*/) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      child: SizedBox(
        width: 343,
        height: 187,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                categoryTitle,
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gap(value: 20),
              Text(
                'Remaining \$' /*${remainingAmount.toString()}*/,
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gap(value: 20),
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
