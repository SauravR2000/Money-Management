// import 'package:json_annotation/json_annotation.dart';

// part 'transaction_model.g.dart';

// @JsonSerializable()
// class TransactionModel {
//   @JsonKey(name: 'user_id')
//   final String userId;
//   final String category;
//   final String description;
//   final String wallet;
//   final String attachment;
//   final bool isExpense;

//   TransactionModel({
//     required this.userId,
//     required this.category,
//     required this.description,
//     required this.wallet,
//     required this.attachment,
//     required this.isExpense,
//   });

//   // Factory method to generate an instance from a JSON map
//   factory TransactionModel.fromJson(Map<String, dynamic> json) =>
//       _$TransactionModelFromJson(json);

//   // Method to convert an instance to a JSON map
//   Map<String, dynamic> toJson() => _$TransactionModelToJson(this);
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    @JsonKey(name: 'user_id') required String userId,
    required String category,
    required String description,
    required String wallet,
    required String attachment,
    required bool isExpense,
    required double amount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TransactionModel;

  // Factory method to generate an instance from a JSON map
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
