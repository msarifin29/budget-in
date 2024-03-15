// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_response.g.dart';

@JsonSerializable(explicitToJson: true)
class Expenseresponse extends Equatable {
  const Expenseresponse({required this.data});
  final ExpenseData data;
  static Expenseresponse fromJson(Map<String, dynamic> json) =>
      _$ExpenseresponseFromJson(json);
  Map<String?, dynamic> toJson() => _$ExpenseresponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'Expenseresponse{data:$data}';
  }
}

@JsonSerializable(explicitToJson: true)
class ExpenseData extends Equatable {
  final String uid;
  final int id;
  @JsonKey(name: "expense_type")
  final String expenseType;
  final double total;
  final String category;
  final String status;
  final String notes;
  final String? createdAt;
  final String? updatedAt;
  const ExpenseData({
    required this.uid,
    required this.id,
    required this.expenseType,
    required this.total,
    required this.category,
    required this.status,
    required this.notes,
    this.createdAt,
    this.updatedAt,
  });
  static ExpenseData fromJson(Map<String, dynamic> json) =>
      _$ExpenseDataFromJson(json);
  Map<String?, dynamic> toJson() => _$ExpenseDataToJson(this);
  @override
  List<Object?> get props => [
        uid,
        id,
        expenseType,
        total,
        category,
        status,
        notes,
        createdAt,
        updatedAt,
      ];
  @override
  String toString() {
    return 'ExpenseData{uid:$uid, id:$id, expenseType:$expenseType, total:$total, category:$category, status:$status, notes:$notes, createdAt:$createdAt, updatedAt:$updatedAt,}';
  }
}
