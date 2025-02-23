import 'package:freezed_annotation/freezed_annotation.dart';

part 'budget_model.freezed.dart';
part 'budget_model.g.dart';

@freezed
class BudgetModel with _$BudgetModel {
  const factory BudgetModel({
    required String id,
    required String title,
    required double amount,
    required String month,
    @JsonKey(name: 'remaining_amount') required double remainingAmount,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _BudgetModel;

  factory BudgetModel.fromJson(Map<String, dynamic> json) =>
      _$BudgetModelFromJson(json);
}
