part of 'budget_bloc.dart';

@freezed
class BudgetEvent with _$BudgetEvent {
  const factory BudgetEvent.started() = _Started;
  const factory BudgetEvent.dataLoaded({
    required String month,
  }) = DataLoadedEvent;
  const factory BudgetEvent.postData({
    required String month,
    required int amount,
    required String category,
    required String userId,
    required bool notification,
  }) = PostDataEvent;
  const factory BudgetEvent.monthlyBudget({
    required String month,
  }) = MonthlyBudgetEvent;
  const factory BudgetEvent.error() = ErrorEvent;
}

// const factory CreatePostEvent.submitPost({Post? post}) = SubmitPostEvent;
