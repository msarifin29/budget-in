// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_response.g.dart';

@JsonSerializable(explicitToJson: true)
class AccountResponse extends Equatable {
  const AccountResponse({required this.data});
  final AccountData data;
  static AccountResponse fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$AccountResponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'AccountResponse{data:$data}';
  }
}

@JsonSerializable(explicitToJson: true)
class AccountData extends Equatable {
  final String uid;
  @JsonKey(name: "account_id")
  final String accountId;
  final String username;
  final String email;
  final String photo;
  @JsonKey(name: "type_user")
  final String typeUser;
  final double balance;
  final double savings;
  final double cash;
  final double debts;
  final String currency;
  final String? createdAt;
  final String? updateddAt;
  const AccountData({
    required this.uid,
    required this.accountId,
    required this.username,
    required this.email,
    required this.photo,
    required this.typeUser,
    required this.balance,
    required this.savings,
    required this.cash,
    required this.debts,
    required this.currency,
    this.createdAt,
    this.updateddAt,
  });
  static AccountData fromJson(Map<String, dynamic> json) =>
      _$AccountDataFromJson(json);
  Map<String?, dynamic> toJson() => _$AccountDataToJson(this);
  @override
  List<Object?> get props => [
        uid,
        accountId,
        username,
        email,
        photo,
        typeUser,
        balance,
        savings,
        cash,
        debts,
        currency,
        createdAt,
        updateddAt,
      ];
  @override
  String toString() {
    return 'AccountData{uid:$uid, accountId:$accountId, username:$username, email:$email, photo:$photo, typeUser:$typeUser, balance:$balance, savings:$savings, cash:$cash, debts:$debts, currency:$currency, createdAt:$createdAt, updateddAt:$updateddAt,}';
  }
}
