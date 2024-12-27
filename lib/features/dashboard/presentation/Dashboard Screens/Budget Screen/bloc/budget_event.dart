part of 'budget_bloc.dart';

@freezed
class BudgetEvent with _$BudgetEvent {
  const factory BudgetEvent.started() = _Started;
  const factory BudgetEvent.dataLoaded() = DataLoadedEvent;
  const factory BudgetEvent.error() = ErrorEvent;
}

// const factory CreatePostEvent.submitPost({Post? post}) = SubmitPostEvent;
