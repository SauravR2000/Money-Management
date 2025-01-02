import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    // int? id,
    @JsonKey(name: 'user_id') required String userId,
    required String category,
    required String description,
    required String wallet,
    required String attachment,
    @JsonKey(name: 'is_expense') required bool isExpense,
    required double amount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TransactionModel;

  // Factory method to generate an instance from a JSON map
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);
}
