// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginResponse extends Equatable {
  const LoginResponse({required this.data});
  final DataLogin data;
  static LoginResponse fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$LoginResponseToJson(this);
  @override
  List<Object?> get props => [data];
}

@JsonSerializable(explicitToJson: true)
class DataLogin extends Equatable {
  const DataLogin({
    required this.token,
    required this.user,
  });
  final String token;
  final User user;
  static DataLogin fromJson(Map<String, dynamic> json) =>
      _$DataLoginFromJson(json);
  Map<String?, dynamic> toJson() => _$DataLoginToJson(this);
  @override
  List<Object?> get props => [token, user];
}

@JsonSerializable(explicitToJson: true)
class User extends Equatable {
  const User({
    required this.uid,
    required this.username,
    required this.accountId,
  });
  final String uid;
  final String username;
  @JsonKey(name: "account_id")
  final String accountId;
  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String?, dynamic> toJson() => _$UserToJson(this);
  @override
  List<Object?> get props => [uid, username, accountId];
}
