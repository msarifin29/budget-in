// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/injection.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponse> login(LoginParams params);
  Future<LoginResponse> register(RegisterParams params);
  Future<AccountResponse> account(String uid);
  Future<DeleteResponse> deleteAccount();
  Future<DynamicResponse> forgotPassword(ForgotPasswordParam param);
  Future<DynamicResponse> resetPassword(ResetPasswordParam param);
  Future<DynamicResponse> checkEmail(String email);
  Future<String> privacyPolice(String lang);
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
    if (response.statusCode == 200) {
      return AccountResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<DeleteResponse> deleteAccount() async {
    final spm = sl<SharedPreferencesManager>();
    var uid = spm.getString(SharedPreferencesManager.keyUid);
    final String path = '$baseUrl/api/user/delete';
    final Response<dynamic> response = await dio.put(
      path,
      options: Options(
        headers: {
          BaseUrlConfig.requiredToken: true,
        },
      ),
      data: {"uid": uid},
    );
    if (response.statusCode == 200) {
      return DeleteResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<DynamicResponse> forgotPassword(ForgotPasswordParam param) async {
    final String path = '$baseUrl/api/user/forgot_password';
    final Response<dynamic> response = await dio.post(
      path,
      data: param.toMap(),
    );
    if (response.statusCode == 200) {
      return DynamicResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<DynamicResponse> resetPassword(ResetPasswordParam param) async {
    final String path = '$baseUrl/api/user/reset_password';
    final Response<dynamic> response = await dio.put(
      path,
      data: param.toMap(),
      options: Options(headers: {
        BaseUrlConfig.requiredToken: true,
      }, extra: {
        BaseUrlConfig.requiredUId: true,
      }),
    );
    if (response.statusCode == 200) {
      return DynamicResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<DynamicResponse> checkEmail(String email) async {
    final String path = '$baseUrl/api/check-email/$email';
    final Response<dynamic> response = await dio.get(path);
    if (response.statusCode == 200) {
      return DynamicResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<String> privacyPolice(String lang) async {
    String path = '$baseUrl/api/privacy-police/$lang';
    final Response<dynamic> response = await dio.get(path);
    if (response.statusCode == 200) {
      return response.data;
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
  final String balance;
  final String cash;
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
      "balance": int.parse(balance.replaceAll(RegExp(r'[^0-9]'), '')),
      "cash": int.parse(cash.replaceAll(RegExp(r'[^0-9]'), '')),
      "type_user": "personal", //by default type_user is personal
    };
  }

  @override
  List<Object?> get props => [username, email, password, balance, cash];
}

class ForgotPasswordParam extends Equatable {
  final String email;
  const ForgotPasswordParam({
    required this.email,
  });
  Map<String, dynamic> toMap() {
    return {"email": email};
  }

  @override
  List<Object?> get props => [email];
}

class ResetPasswordParam extends Equatable {
  final String oldPassword;
  final String newPassword;
  const ResetPasswordParam({
    required this.oldPassword,
    required this.newPassword,
  });
  Map<String, dynamic> toMap() {
    return {
      "old_password": oldPassword,
      "new_password": newPassword,
    };
  }

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
