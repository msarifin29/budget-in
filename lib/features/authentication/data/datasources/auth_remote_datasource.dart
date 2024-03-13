// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/data/models/account_response.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:budget_in/features/authentication/authentication.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginParams params);
  Future<LoginResponse> register(RegisterParams params);
  Future<AccountResponse> account(String uid);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl({
    required this.dio,
  });

  final baseUrl = dotenv.env['BASE_URL'];

  @override
  Future<LoginResponse> login(LoginParams params) async {
    final String path = '$baseUrl/api/login';
    final Response<dynamic> response = await dio.post(
      path,
      data: params.toMap(),
    );
    log('login datasource => ${response.data}');
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<LoginResponse> register(RegisterParams params) async {
    final String path = '$baseUrl/api/register';
    final Response<dynamic> response = await dio.post(
      path,
      data: params.toMap(),
    );
    if (response.statusCode == 200) {
      return LoginResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<AccountResponse> account(String uid) async {
    final String path = '$baseUrl/api/user/$uid';
    final Response<dynamic> response = await dio.get(path,
        options: Options(headers: {
          BaseUrlConfig.requiredToken: true,
        }));
    log('account datasource => ${response.data}');
    if (response.statusCode == 200) {
      return AccountResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;
  const LoginParams({
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toMap() {
    return {"email": email, "password": password};
  }

  @override
  List<Object?> get props => [email, password];
}

class RegisterParams extends Equatable {
  final String username;
  final String email;
  final String password;
  final double balance;
  final double cash;
  const RegisterParams({
    required this.email,
    required this.password,
    required this.username,
    required this.balance,
    required this.cash,
  });
  Map<String, dynamic> toMap() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "balance": balance,
      "cash": cash,
      "type_user": "personal", //by default type_user is personal
    };
  }

  @override
  List<Object?> get props => [username, email, password, balance, cash];
}
