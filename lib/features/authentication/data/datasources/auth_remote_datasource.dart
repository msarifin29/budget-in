// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import 'package:budget_in/features/authentication/authentication.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginParams params);
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
  List<Object?> get props => throw UnimplementedError();
}
