part of 'global_bloc.dart';

@freezed
class GlobalState with _$GlobalState {
  const factory GlobalState.initial() = Initial;

  const factory GlobalState.userDetailState() = UserDetailStateState;


}
