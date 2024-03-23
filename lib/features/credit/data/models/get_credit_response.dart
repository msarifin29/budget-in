// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:budget_in/features/credit/data/models/credit_response.dart';

part 'get_credit_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetCreditResponse extends Equatable {
  const GetCreditResponse({required this.data});
  final GetCreditData data;
  static GetCreditResponse fromJson(Map<String, dynamic> json) =>
      _$GetCreditResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$GetCreditResponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'GetCreditResponse{}';
  }
}

@JsonSerializable(explicitToJson: true)
class GetCreditData extends Equatable {
  const GetCreditData({
    required this.page,
    required this.totalPage,
    required this.lastPage,
    required this.total,
    required this.data,
  });
  final int page;
  @JsonKey(name: "total_page")
  final int totalPage;
  @JsonKey(name: "last_page")
  final int lastPage;
  final int total;
  final List<CreditData> data;
  static GetCreditData fromJson(Map<String, dynamic> json) =>
      _$GetCreditDataFromJson(json);
  Map<String?, dynamic> toJson() => _$GetCreditDataToJson(this);
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
    return 'GetCreditData{}';
  }
}
