import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/budget_screen_ui.dart';

part 'budget_month_cubit.freezed.dart';
part 'budget_month_state.dart';

@injectable
class BudgetMonthCubit extends Cubit<BudgetMonthState> {
  String? month;

  int pageIndex = 0;

  BudgetMonthCubit() : super(BudgetMonthState.initial());

  void changeMonth(String selectedMonth) {
    month = selectedMonth;
    emit(BudgetMonthSelectedState(selectedMonth: month));
  }

  void nextMonthSlide() {
    if (pageIndex < budgetMonths.length - 1) {
      pageIndex++;

      emit(BudgetNextMonthSelectedState(index: pageIndex));
    }
  }

  void previousMonthSlide() {
    if (pageIndex > 0) {
      pageIndex--;

      emit(BudgetPreviousMonthSelectedState(index: pageIndex));
    }
  }
}
