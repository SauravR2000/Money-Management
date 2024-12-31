part of 'budget_bloc.dart';

@freezed
class BudgetState with _$BudgetState {
  const factory BudgetState.initial() = _Initial;

  const factory BudgetState.dataLoaded({required List<BudgetModel> budgets}) =
      DataLoadedState;

  const factory BudgetState.postData({
    required String month,
    required int amount,
    required String category,
    required String userId,
    required bool notification,
  }) = PostDataState;

  const factory BudgetState.error({required String message}) = ErrorState;
}
