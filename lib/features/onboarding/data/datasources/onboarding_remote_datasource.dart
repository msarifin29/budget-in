// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';

abstract class OnboardingRemoteDatasource {
  Future<MonthlyReportResponse> getMonthlyReport(String uid);
  Future<MaxBudgetResponse> getMaximumBudget(GetMaxBudgetparam param);
  Future<UpdateBudgetResponse> updateMaxBudget(UpdateMaxBudgetparam param);
  Future<MonthlyReportDetailResponse> monthlyReportDetail(
      MonthlyReportDetailParam param);
  Future<MonthlyReportCategoryResponse> monthlyReportCategory(
      MonthlyReportDetailParam param);
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
  Future<MaxBudgetResponse> getMaximumBudget(GetMaxBudgetparam param) async {
    final String path = '$baseUrl/api/accounts/max_budget';
    final Response<dynamic> response = await dio.get(
      path,
      options: Options(
        headers: {
          BaseUrlConfig.requiredToken: true,
        },
      ),
      queryParameters: param.toMap(),
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

  @override
  Future<MonthlyReportDetailResponse> monthlyReportDetail(
      MonthlyReportDetailParam param) async {
    final String path = '$baseUrl/api/user/monthly-report-detail';
    final Response<dynamic> response = await dio.get(
      path,
      options: Options(
        headers: {BaseUrlConfig.requiredToken: true},
      ),
      queryParameters: param.toMap(),
    );
    if (response.statusCode == 200) {
      return MonthlyReportDetailResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<MonthlyReportCategoryResponse> monthlyReportCategory(
      MonthlyReportDetailParam param) async {
    final String path = '$baseUrl/api/user/monthly-report/category';
    final Response<dynamic> response = await dio.get(
      path,
      options: Options(
        headers: {BaseUrlConfig.requiredToken: true},
      ),
      queryParameters: param.toMap(),
    );
    if (response.statusCode == 200) {
      return MonthlyReportCategoryResponse.fromJson(response.data);
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

class GetMaxBudgetparam extends Equatable {
  final String accountId;
  final String uid;
  const GetMaxBudgetparam({
    required this.accountId,
    required this.uid,
  });
  Map<String, dynamic> toMap() {
    return {"account_id": accountId, "uid": uid};
  }

  @override
  List<Object?> get props => [];
}

class MonthlyReportDetailParam extends Equatable {
  final String month;
  const MonthlyReportDetailParam({
    required this.month,
  });
  Map<String, dynamic> toMap() {
    return {"month": month};
  }

  @override
  List<Object?> get props => [month];
}
