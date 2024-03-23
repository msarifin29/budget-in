// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_in/core/core.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:budget_in/features/credit/credits.dart';

abstract class CreditRemoteDatasource {
  Future<CreditResponse> create(CreateCreditParams params);
  Future<GetCreditResponse> getCredits(GetCreditParams params);
  Future<HistoryResponse> getHistories(GetCreditParams params);
}

class CreditRemoteDatasourceImpl extends CreditRemoteDatasource {
  final Dio dio;
  CreditRemoteDatasourceImpl({
    required this.dio,
  });
  final baseUrl = dotenv.env['BASE_URL'];
  @override
  Future<CreditResponse> create(CreateCreditParams params) async {
    final String path = '$baseUrl/api/credits/create';
    final Response<dynamic> response = await dio.post(
      path,
      options: Options(
        headers: {
          BaseUrlConfig.requiredToken: true,
        },
      ),
      data: params.toMap(),
    );
    if (response.statusCode == 200) {
      return CreditResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<GetCreditResponse> getCredits(GetCreditParams params) async {
    final String path = '$baseUrl/api/credits';
    final Response<dynamic> response = await dio.get(path,
        options: Options(
          headers: {
            BaseUrlConfig.requiredToken: true,
          },
        ),
        queryParameters: params.toMap());
    if (response.statusCode == 200) {
      return GetCreditResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<HistoryResponse> getHistories(GetCreditParams params) async {
    final String path = '$baseUrl/api/histories_credits';
    final Response<dynamic> response = await dio.get(path,
        options: Options(headers: {
          BaseUrlConfig.requiredToken: true,
        }),
        queryParameters: params.toMap());
    if (response.statusCode == 200) {
      return HistoryResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }
}

class CreateCreditParams extends Equatable {
  final String uid;
  final int categoryId;
  final String typeCredit;
  final int loanTerm;
  final int installment;
  final int paymentTime;
  const CreateCreditParams({
    required this.uid,
    required this.categoryId,
    required this.typeCredit,
    required this.loanTerm,
    required this.installment,
    required this.paymentTime,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "uid": uid,
      "category_id": categoryId,
      "type_credit": typeCredit,
      "loan_term": loanTerm,
      "installment": installment,
      "payment_time": paymentTime,
    };
    return data;
  }

  @override
  List<Object?> get props => [];
}

class GetCreditParams extends Equatable {
  final int page;
  final int totalPage;
  const GetCreditParams({
    required this.page,
    required this.totalPage,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "page": page,
      "total_page": totalPage,
    };
    return data;
  }

  @override
  List<Object?> get props => [];
}
