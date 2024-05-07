// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'monthly_report_detail_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MonthlyReportDetailResponse extends Equatable {
  const MonthlyReportDetailResponse({
    required this.data,
  });
  final MonthlyReportDetailData data;
  static MonthlyReportDetailResponse fromJson(Map<String, dynamic> json) =>
      _$MonthlyReportDetailResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$MonthlyReportDetailResponseToJson(this);
  @override
  List<Object?> get props => [data];
}

@JsonSerializable(explicitToJson: true)
class MonthlyReportDetailData extends Equatable {
  const MonthlyReportDetailData({
    required this.expenses,
    required this.incomes,
  });
  final List<VExpense> expenses;
  final List<VIncome> incomes;
  static MonthlyReportDetailData fromJson(Map<String, dynamic> json) =>
      _$MonthlyReportDetailDataFromJson(json);
  Map<String?, dynamic> toJson() => _$MonthlyReportDetailDataToJson(this);
  @override
  List<Object?> get props => [expenses, incomes];
}

@JsonSerializable(explicitToJson: true)
class VExpense extends Equatable {
  const VExpense({
    required this.month,
    required this.uid,
    required this.expenseType,
    required this.total,
    required this.status,
    required this.notes,
    required this.transactionId,
    required this.tCategory,
    required this.createdAt,
  });
  final String month;
  final String uid;
  @JsonKey(name: "expense_type")
  final String expenseType;
  final int total;
  final String status;
  final String notes;
  @JsonKey(name: "transaction_id")
  final String transactionId;
  @JsonKey(name: "t_category")
  final TCategory tCategory;
  @JsonKey(name: "created_at")
  final String createdAt;
  static VExpense fromJson(Map<String, dynamic> json) =>
      _$VExpenseFromJson(json);
  Map<String?, dynamic> toJson() => _$VExpenseToJson(this);
  @override
  List<Object?> get props => [
        month,
        uid,
        expenseType,
        total,
        status,
        notes,
        transactionId,
        tCategory,
        createdAt,
      ];
}

@JsonSerializable(explicitToJson: true)
class VIncome extends Equatable {
  final String month;
  final String uid;
  @JsonKey(name: "type_income")
  final String typeIncome;
  final int total;
  @JsonKey(name: "transaction_id")
  final String transactionId;
  @JsonKey(name: "t_category")
  final TCategory tCategory;
  @JsonKey(name: "created_at")
  final String createdAt;
  const VIncome({
    required this.month,
    required this.uid,
    required this.typeIncome,
    required this.total,
    required this.transactionId,
    required this.tCategory,
    required this.createdAt,
  });
  static VIncome fromJson(Map<String, dynamic> json) => _$VIncomeFromJson(json);
  Map<String?, dynamic> toJson() => _$VIncomeToJson(this);
  @override
  List<Object?> get props => [
        month,
        uid,
        typeIncome,
        total,
        transactionId,
        tCategory,
        createdAt,
      ];
}

@JsonSerializable(explicitToJson: true)
class TCategory extends Equatable {
  @JsonKey(name: "category_id")
  final int? categoryId;
  @JsonKey(name: "t_id")
  final int? tId;
  final String? title;
  const TCategory({
    this.categoryId,
    this.tId,
    this.title,
  });
  static TCategory fromJson(Map<String, dynamic> json) =>
      _$TCategoryFromJson(json);
  Map<String?, dynamic> toJson() => _$TCategoryToJson(this);
  @override
  List<Object?> get props => [
        categoryId,
        tId,
        title,
      ];
}
