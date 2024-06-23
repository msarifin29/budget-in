// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'monthly_report_category_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MonthlyReportCategoryResponse extends Equatable {
  const MonthlyReportCategoryResponse({
    required this.data,
  });
  final MonthlyCategoryData data;
  static MonthlyReportCategoryResponse fromJson(Map<String, dynamic> json) =>
      _$MonthlyReportCategoryResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$MonthlyReportCategoryResponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'MonthlyReportCategoryResponse{data:$data}';
  }
}

@JsonSerializable(explicitToJson: true)
class MonthlyCategoryData extends Equatable {
  const MonthlyCategoryData({
    required this.incomes,
    required this.expenses,
  });
  final List<CategoryValue> incomes;
  final List<CategoryValue> expenses;
  static MonthlyCategoryData fromJson(Map<String, dynamic> json) =>
      _$MonthlyCategoryDataFromJson(json);
  Map<String?, dynamic> toJson() => _$MonthlyCategoryDataToJson(this);
  @override
  List<Object?> get props => [incomes, expenses];
  @override
  String toString() {
    return 'MonthlyCategoryData{incomes:$incomes, expenses:$expenses}';
  }
}

@JsonSerializable(explicitToJson: true)
class CategoryValue extends Equatable {
  const CategoryValue({
    required this.categoryId,
    required this.title,
    required this.total,
  });
  @JsonKey(name: "category_id")
  final String categoryId;
  final String title;
  final double total;

  static CategoryValue fromJson(Map<String, dynamic> json) =>
      _$CategoryValueFromJson(json);
  Map<String?, dynamic> toJson() => _$CategoryValueToJson(this);
  @override
  List<Object?> get props => [
        categoryId,
        title,
        total,
      ];
  @override
  String toString() {
    return 'CategoryValue{categoryId:$categoryId, title:$title, total:$total}';
  }
}
