part of 'profile_cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  const factory ProfileState.userName({required String userName}) =
      UserNameState;

  const factory ProfileState.profileUpdatedSuccess() =
      ProfileUpdatedSuccessState;

  const factory ProfileState.profileLoading() = ProfileLoadingState;

  const factory ProfileState.profileError({required String error}) =
      ProfileErrorState;
}
