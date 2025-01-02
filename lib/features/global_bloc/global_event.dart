part of 'global_bloc.dart';

@freezed
class GlobalEvent with _$GlobalEvent {
  const factory GlobalEvent.started() = _Started;

  const factory GlobalEvent.getUserDetail() = GetUserDetail;

  const factory GlobalEvent.updateUserDetail({
    required String userName,
    required String imageUrl,
  }) = UpdateUserDetail;
}
