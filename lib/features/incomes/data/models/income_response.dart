// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'income_response.g.dart';

@JsonSerializable(explicitToJson: true)
class IncomeResponse extends Equatable {
  const IncomeResponse({required this.data});
  final IncomeData data;
  static IncomeResponse fromJson(Map<String, dynamic> json) =>
      _$IncomeResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$IncomeResponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'IncomeResponse{data:$data}';
  }
}

@JsonSerializable(explicitToJson: true)
class IncomeData extends Equatable {
  final int id;
  @JsonKey(name: "category_income")
  final String categoryIncome;
  @JsonKey(name: "type_income")
  final String typeIncome;
  final int total;
  @JsonKey(name: "transaction_id")
  final String? transactionId;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  const IncomeData({
    required this.id,
    required this.categoryIncome,
    required this.typeIncome,
    required this.total,
    this.transactionId,
    required this.createdAt,
    this.updatedAt,
  });
  static IncomeData fromJson(Map<String, dynamic> json) =>
      _$IncomeDataFromJson(json);
  Map<String?, dynamic> toJson() => _$IncomeDataToJson(this);
  @override
  List<Object?> get props => [
        id,
        categoryIncome,
        typeIncome,
        total,
        transactionId,
        createdAt,
        updatedAt,
      ];
  @override
  String toString() {
    return 'IncomeData{}';
  }
}
