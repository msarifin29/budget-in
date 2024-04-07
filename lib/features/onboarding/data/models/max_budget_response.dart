// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'max_budget_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MaxBudgetResponse extends Equatable {
  const MaxBudgetResponse(this.data);
  final MaxBudgetData data;
  static MaxBudgetResponse fromJson(Map<String, dynamic> json) =>
      _$MaxBudgetResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$MaxBudgetResponseToJson(this);
  @override
  List<Object?> get props => [data];
}

@JsonSerializable(explicitToJson: true)
class MaxBudgetData extends Equatable {
  const MaxBudgetData({
    required this.maxBudget,
    required this.totalExpense,
  });
  @JsonKey(name: "max_budget")
  final double maxBudget;
  @JsonKey(name: "total_expense")
  final double totalExpense;
  static MaxBudgetData fromJson(Map<String, dynamic> json) =>
      _$MaxBudgetDataFromJson(json);
  Map<String?, dynamic> toJson() => _$MaxBudgetDataToJson(this);
  @override
  List<Object?> get props => [maxBudget, totalExpense];
}
