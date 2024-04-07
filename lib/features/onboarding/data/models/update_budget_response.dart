// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_budget_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateBudgetResponse extends Equatable {
  const UpdateBudgetResponse(this.data);
  final bool data;
  static UpdateBudgetResponse fromJson(Map<String, dynamic> json) =>
      _$UpdateBudgetResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$UpdateBudgetResponseToJson(this);
  @override
  List<Object?> get props => [data];
}
