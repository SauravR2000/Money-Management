part of 'budget_bloc.dart';

@freezed
class BudgetState with _$BudgetState {
  const factory BudgetState.initial() = Initial;

  const factory BudgetState.loading() = BudgetLoadingState;

  const factory BudgetState.dataLoaded({required List<BudgetModel> budgets}) =
      DataLoadedState;

  const factory BudgetState.postData() = PostDataState;

  const factory BudgetState.deleteBudget() = DeleteBudgetState;

  const factory BudgetState.error({required String message}) = ErrorState;

}
