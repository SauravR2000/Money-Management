import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:money_management_app/config/router/app_router.gr.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/bloc/budget_bloc.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/cubit/budget_month_cubit.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/month_carousel.dart';
import 'package:money_management_app/shared_widgets/progress_indicator.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/strings.dart';

List<String> budgetMonths = [
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

@RoutePage()
class BudgetScreenUi extends StatefulWidget {
  const BudgetScreenUi({super.key});

  @override
  State<BudgetScreenUi> createState() => _BudgetScreenUiState();
}

class _BudgetScreenUiState extends State<BudgetScreenUi> {
  late BudgetBloc _budgetBloc;
  late BudgetMonthCubit _budgetMonthCubit;

  _initializedBudgetMonths() {
    budgetMonths;
  }

  @override
  void initState() {
    _budgetBloc = BudgetBloc();
    _budgetMonthCubit = getIt<BudgetMonthCubit>();

    _budgetBloc
        .add(DataLoadedEvent(month: _budgetMonthCubit.month ?? 'January'));
    _initializedBudgetMonths();
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
            monthCarouselSlider(),
            gap(value: 16),
            Expanded(
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: BlocBuilder<BudgetBloc, BudgetState>(
                  bloc: _budgetBloc,
                  builder: (context, state) {
                    log("budget state = $state");

                    switch (state) {
                      case BudgetLoadingState():
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case DataLoadedState():
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
                                                      .budgetList[index].amount
                                                      .toDouble(),
                                                  _budgetBloc.budgetList[index]
                                                      .remainingAmount,
                                                  _budgetBloc
                                                      .budgetList[index].id),
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
                                  style: Theme.of(context)
                                      .elevatedButtonTheme
                                      .style,
                                  onPressed: () {
                                    context.router.push(AddBudgetRoute(
                                        month: _budgetMonthCubit.month ??
                                            'January'));
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
                      default:
                        return Text(AppStrings.somethingWentWrong);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget monthCarouselSlider() {
    return BlocConsumer<BudgetMonthCubit, BudgetMonthState>(
      bloc: _budgetMonthCubit,
      listener: (context, state) {
        if (state is BudgetMonthSelectedState) {
          _budgetMonthCubit.changeMonth(state.selectedMonth.toString());
        }
      },
      builder: (context, state) {
        return monthCarousel(
          budgetBloc: _budgetBloc,
          bloc: _budgetMonthCubit,
          months: budgetMonths,
          screenContext: context,
        );
      },
    );
  }

  Widget budgetCards(
    String categoryTitle,
    double budgetAmount,
    double remainingAmount,
    String categoryId,
  ) {
    return Card(
      elevation: 5,
      shadowColor: Colors.grey,
      child: SizedBox(
        width: 343,
        // height: 187,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: Text(
                      categoryTitle,
                      style: GoogleFonts.aBeeZee(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Show the AlertDialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                                'Are you sure you want to delete this budget?'),
                            content: Text('This action cannot be undone.'),
                            actions: [
                              TextButton(
                                child: Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: Text('Delete'),
                                onPressed: () {
                                  _budgetBloc.add(
                                    DeleteMonthBudgetEvent(
                                      categoryId: categoryId,
                                    ),
                                  );
                                  Navigator.of(context)
                                      .pop(); // Close the dialog after action
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: Icon(
                      Icons.delete,
                    ),
                  )
                ],
              ),
              gap(value: 10),
              Text(
                remainingAmount < 0
                    ? 'Remaining Rs.0'
                    : 'Remaining Rs.${remainingAmount.toStringAsFixed(1)}',
                style: GoogleFonts.aBeeZee(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gap(value: 5),
              CustomProgressIndicator(
                height: 10,
                width: MediaQuery.of(context).size.width,
                progress: (remainingAmount / budgetAmount),
              ),
              gap(value: 20),
              Text(
                remainingAmount < 0
                    ? 'Rs.${(remainingAmount.abs() + budgetAmount).toStringAsFixed(1)} of Rs.${budgetAmount.toStringAsFixed(1)}'
                    : 'Rs.${remainingAmount.toString()} of Rs.${budgetAmount.toString()}',
                style: GoogleFonts.aBeeZee(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              gap(value: 5),
              if (remainingAmount < 0) ...{
                Text(
                  'You have exceeded the limit!',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                )
              }
            ],
          ),
        ),
      ),
    );
  }
}
