// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pay_credit_response.g.dart';

@JsonSerializable(explicitToJson: true)
class PayCreditResponse extends Equatable {
  const PayCreditResponse({required this.data});
  final PayCreditData data;
  static PayCreditResponse fromJson(Map<String, dynamic> json) =>
      _$PayCreditResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$PayCreditResponseToJson(this);
  @override
  List<Object?> get props => [data];
}

@JsonSerializable(explicitToJson: true)
class PayCreditData extends Equatable {
  final int id;
  final int th;
  final int total;
  final String status;
  @JsonKey(name: "type_payment")
  final String typePayment;
  @JsonKey(name: "created_at")
  final String createdAt;
  const PayCreditData({
    required this.id,
    required this.th,
    required this.total,
    required this.status,
    required this.typePayment,
    required this.createdAt,
  });
  static PayCreditData fromJson(Map<String, dynamic> json) =>
      _$PayCreditDataFromJson(json);
  Map<String?, dynamic> toJson() => _$PayCreditDataToJson(this);
  @override
  List<Object?> get props => [
        id,
        th,
        total,
        status,
        typePayment,
        createdAt,
      ];
}
