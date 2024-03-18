// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'monthly_report.g.dart';

@JsonSerializable(explicitToJson: true)
class MonthlyReportResponse extends Equatable {
  const MonthlyReportResponse({
    required this.data,
  });
  final List<MonthlyReportData> data;
  static MonthlyReportResponse fromJson(Map<String, dynamic> json) =>
      _$MonthlyReportResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$MonthlyReportResponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'MonthlyReportResponse{data:$data}';
  }
}

@JsonSerializable(explicitToJson: true)
class MonthlyReportData extends Equatable {
  const MonthlyReportData({
    required this.month,
    required this.year,
    required this.totalIncome,
    required this.totalExpense,
  });
  final int month;
  final int year;
  @JsonKey(name: "total_income")
  final int totalIncome;
  @JsonKey(name: "total_expense")
  final int totalExpense;
  static MonthlyReportData fromJson(Map<String, dynamic> json) =>
      _$MonthlyReportDataFromJson(json);
  Map<String?, dynamic> toJson() => _$MonthlyReportDataToJson(this);
  @override
  List<Object?> get props => [
        month,
        year,
        totalIncome,
        totalExpense,
      ];
  @override
  String toString() {
    return 'MonthlyReportData{month:$month, year:$year, totalIncome:$totalIncome, totalExpense:$totalExpense,}';
  }
}
