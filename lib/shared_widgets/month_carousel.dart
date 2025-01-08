import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/bloc/budget_bloc.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/budget_screen_ui.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/cubit/budget_month_cubit.dart';

Widget monthCarousel({
  required BudgetBloc budgetBloc,
  required BudgetMonthCubit bloc,
  required List<String> months,
  required BuildContext screenContext,
}) {
  final PageController carouselController = PageController();

  return BlocListener<BudgetMonthCubit, BudgetMonthState>(
    bloc: bloc,
    listener: (context, state) {
      carouselController.animateToPage(
        bloc.pageIndex,
        duration: Duration(milliseconds: 120),
        curve: Curves.easeInOut,
      );
    },
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  bloc.pageIndex == 0 ? null : bloc.previousMonthSlide();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
                width: 200,
                child: PageView(
                  controller: carouselController,
                  physics: NeverScrollableScrollPhysics(),
                  children: budgetMonths 
                      .map(
                        (item) => Center(
                          child: Text(
                            item,
                            style: Theme.of(screenContext)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      )
                      .toList(),
                  onPageChanged: (currentIndex) {
                    budgetBloc.add(
                        DataLoadedEvent(month: budgetMonths[currentIndex]));
                    bloc.changeMonth(budgetMonths[currentIndex]);
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  bloc.pageIndex == budgetMonths.length - 1
                      ? null
                      : bloc.nextMonthSlide();

                  budgetBloc.add(
                      DataLoadedEvent(month: budgetMonths[bloc.pageIndex]));
                },
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
      ],
    ),

    // return CarouselSlider(
    //   items: months
    //       .map((item) => Center(
    //               child: Text(
    //             item,
    //             style: Theme.of(context).textTheme.headlineLarge!.copyWith(
    //                   color: Colors.white,
    //                 ),
    //           )))
    //       .toList(),
    //   options: CarouselOptions(
    //     height: 30,
    //     autoPlay: false,
    //     enlargeCenterPage: true,
    //     enableInfiniteScroll: false,
    //     onPageChanged: (value, _) {
    //       bloc.changeMonth(value.toString());
    //     },
    //   ),
    // );,
  );
}
