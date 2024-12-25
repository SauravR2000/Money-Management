part of 'budget_bloc.dart';

@freezed
class BudgetState with _$BudgetState {
  const factory BudgetState.initial() = _Initial;

  const factory BudgetState.dataLoaded(
      {required double budgetAmount,
      required String category}) = DataLoadedState;
}
