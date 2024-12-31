import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_model.freezed.dart';
part 'update_user_model.g.dart';

@freezed
class UpdateUserModel with _$UpdateUserModel {
  const factory UpdateUserModel({
    String? userName,
    String? imageId,
  }) = _UpdateUserModel;

  // Factory method to generate an instance from a JSON map
  factory UpdateUserModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserModelFromJson(json);
}
