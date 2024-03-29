// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class OnboardingRemoteDatasource {
  Future<MonthlyReportResponse> getMonthlyReport(String uid);
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
}
