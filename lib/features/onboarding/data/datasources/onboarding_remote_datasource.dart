// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/injection.dart';

abstract class OnboardingRemoteDatasource {
  Future<MonthlyReportResponse> getMonthlyReport(String uid);
  Future<MaxBudgetResponse> getMaximumBudget();
  Future<UpdateBudgetResponse> updateMaxBudget(UpdateMaxBudgetparam param);
}

class OnboardingRemoteDatasourceImpl extends OnboardingRemoteDatasource {
  final Dio dio;
  OnboardingRemoteDatasourceImpl({
    required this.dio,
  });

  final baseUrl = dotenv.env['BASE_URL'];

  @override
  Future<MonthlyReportResponse> getMonthlyReport(String uid) async {
    final String path = '$baseUrl/api/user/monthly_report/$uid';
    final Response<dynamic> response = await dio.get(path,
        options: Options(headers: {
          BaseUrlConfig.requiredToken: true,
        }));
    if (response.statusCode == 200) {
      return MonthlyReportResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<MaxBudgetResponse> getMaximumBudget() async {
    final spm = sl<SharedPreferencesManager>();
    var accountId = spm.getString(SharedPreferencesManager.keyAccountId);
    var uId = spm.getString(SharedPreferencesManager.keyUid);
    final String path = '$baseUrl/api/accounts/max_budget';
    final Response<dynamic> response = await dio.get(
      path,
      options: Options(headers: {
        BaseUrlConfig.requiredToken: true,
      }),
      queryParameters: {"uid": uId, "account_id": accountId},
    );

    if (response.statusCode == 200) {
      return MaxBudgetResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<UpdateBudgetResponse> updateMaxBudget(
      UpdateMaxBudgetparam param) async {
    final String path = '$baseUrl/api/accounts/update_max_budget';
    final Response<dynamic> response = await dio.put(
      path,
      options: Options(headers: {
        BaseUrlConfig.requiredToken: true,
      }, extra: {
        BaseUrlConfig.requiredAccountId: true,
        BaseUrlConfig.requiredUId: true,
      }),
      data: param.toMap(),
    );
    if (response.statusCode == 200) {
      return UpdateBudgetResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }
}

class UpdateMaxBudgetparam extends Equatable {
  final String maxBudget;
  const UpdateMaxBudgetparam({
    required this.maxBudget,
  });
  Map<String, dynamic> toMap() {
    return {
      "max_budget": double.parse(maxBudget.replaceAll(RegExp(r'[^0-9]'), ''))
    };
  }

  @override
  List<Object?> get props => [];
}
