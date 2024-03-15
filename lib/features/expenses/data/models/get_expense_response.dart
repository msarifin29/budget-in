// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:budget_in/features/expenses/expenses.dart';

part 'get_expense_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetExpenseResponse extends Equatable {
  const GetExpenseResponse({required this.data});
  final GetExpenseData data;
  static GetExpenseResponse fromJson(Map<String, dynamic> json) =>
      _$GetExpenseResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$GetExpenseResponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'GetExpenseResponse{data:$data}';
  }
}

@JsonSerializable(explicitToJson: true)
class GetExpenseData extends Equatable {
  final int page;
  @JsonKey(name: 'total_page')
  final int totalPage;
  @JsonKey(name: 'last_page')
  final int lastPage;
  final int total;
  final List<ExpenseData> data;
  const GetExpenseData({
    required this.page,
    required this.totalPage,
    required this.lastPage,
    required this.total,
    required this.data,
  });
  static GetExpenseData fromJson(Map<String, dynamic> json) =>
      _$GetExpenseDataFromJson(json);
  Map<String?, dynamic> toJson() => _$GetExpenseDataToJson(this);
  @override
  List<Object?> get props => [
        page,
        totalPage,
        lastPage,
        total,
        data,
      ];
  @override
  String toString() {
    return 'GetExpenseData{page:$page, totalPage:$totalPage, lastPage:$lastPage, total:$total, data:$data,}';
  }
}
