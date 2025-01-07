part of 'budget_month_cubit.dart';

@freezed
class BudgetMonthState with _$BudgetMonthState {
  const factory BudgetMonthState.initial() = _Initial;
  const factory BudgetMonthState.monthSelected({required String? selectedMonth}) = BudgetMonthSelectedState;
  const factory BudgetMonthState.nextMonthSelected({required int? index}) = BudgetNextMonthSelectedState;
  const factory BudgetMonthState.previousMonthSelected({required int? index}) = BudgetPreviousMonthSelectedState;
}
