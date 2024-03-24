// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:budget_in/core/core.dart';

part 'credit_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditResponse extends Equatable {
  const CreditResponse({required this.data});
  final CreditData data;
  static CreditResponse fromJson(Map<String, dynamic> json) =>
      _$CreditResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$CreditResponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'CreditResponse{}';
  }
}

@JsonSerializable(explicitToJson: true)
class CreditData extends Equatable {
  final String uid;
  final int id;
  @JsonKey(name: "type_credit")
  final String typeCredit;
  final int total;
  @JsonKey(name: "loan_term")
  final int loanTerm;
  @JsonKey(name: "payment_time")
  final int paymentTime;
  @JsonKey(name: "created_at")
  final String? createdAt;
  @JsonKey(name: "updated_at")
  final String? updatedAt;
  @JsonKey(name: "status_credit")
  final String statusCredit;
  final int installment;
  @JsonKey(name: "t_category")
  final CategoryData? categoryData;
  const CreditData({
    required this.uid,
    required this.id,
    required this.typeCredit,
    required this.total,
    required this.loanTerm,
    required this.paymentTime,
    this.createdAt,
    this.updatedAt,
    required this.statusCredit,
    required this.installment,
    this.categoryData,
  });

  static CreditData fromJson(Map<String, dynamic> json) =>
      _$CreditDataFromJson(json);
  Map<String?, dynamic> toJson() => _$CreditDataToJson(this);
  @override
  List<Object?> get props => [
        uid,
        id,
        typeCredit,
        total,
        loanTerm,
        paymentTime,
        createdAt,
        updatedAt,
        statusCredit,
        installment,
        categoryData,
      ];
  @override
  String toString() {
    return 'CreditData{}';
  }
}
