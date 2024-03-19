// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:budget_in/features/incomes/data/models/income_response.dart';

part 'get_income_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetIncomeResponse extends Equatable {
  const GetIncomeResponse({required this.data});
  final GetIncomeData data;
  static GetIncomeResponse fromJson(Map<String, dynamic> json) =>
      _$GetIncomeResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$GetIncomeResponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'GetIncomeResponse{}';
  }
}

@JsonSerializable(explicitToJson: true)
class GetIncomeData extends Equatable {
  final int page;
  @JsonKey(name: "total_page")
  final int totalPage;
  @JsonKey(name: "last_page")
  final int lastPage;
  final int total;
  final List<IncomeData> data;
  const GetIncomeData({
    required this.page,
    required this.totalPage,
    required this.lastPage,
    required this.total,
    required this.data,
  });
  static GetIncomeData fromJson(Map<String, dynamic> json) =>
      _$GetIncomeDataFromJson(json);
  Map<String?, dynamic> toJson() => _$GetIncomeDataToJson(this);
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
    return 'GetIncomeData{}';
  }
}
