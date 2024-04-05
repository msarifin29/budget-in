// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';

abstract class CreditRemoteDatasource {
  Future<CreditResponse> create(CreateCreditParams params);
  Future<GetCreditResponse> getCredits(GetCreditParams params);
  Future<HistoryResponse> getHistories(GetHistorisCreditParams params);
  Future<PayCreditResponse> payCredit(UpdateCreditParams params);
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
    final Response<dynamic> response = await dio.get(
      path,
      options: Options(
        headers: {
          BaseUrlConfig.requiredToken: true,
        },
      ),
      queryParameters: params.toMap(),
    );
    log('${response.data}');
    if (response.statusCode == 200) {
      return GetCreditResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<HistoryResponse> getHistories(GetHistorisCreditParams params) async {
    final String path = '$baseUrl/api/histories_credits';
    final Response<dynamic> response = await dio.get(
      path,
      options: Options(headers: {
        BaseUrlConfig.requiredToken: true,
      }),
      queryParameters: params.toMap(),
    );
    log('${response.data}');
    if (response.statusCode == 200) {
      return HistoryResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<PayCreditResponse> payCredit(UpdateCreditParams params) async {
    final String path = '$baseUrl/api/credits/update_history';
    final Response<dynamic> response = await dio.put(
      path,
      options: Options(headers: {
        BaseUrlConfig.requiredToken: true,
      }),
      data: params.toMap(),
    );
    if (response.statusCode == 200) {
      return PayCreditResponse.fromJson(response.data);
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
  final String installment;
  final String startDate;
  final String endDate;
  const CreateCreditParams({
    required this.uid,
    required this.categoryId,
    required this.typeCredit,
    required this.installment,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "uid": uid,
      "category_id": categoryId,
      "type_credit": typeCredit,
      "start_date": startDate,
      "installment": int.parse(installment.replaceAll(RegExp(r'[^0-9]'), '')),
      "end_date": endDate,
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

  GetCreditParams copyWith({int? page, int? totalPage}) {
    return GetCreditParams(
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
    );
  }

  @override
  List<Object?> get props => [page, totalPage];
}

class GetHistorisCreditParams extends Equatable {
  final int page;
  final int totalPage;
  final int creditId;
  const GetHistorisCreditParams({
    required this.page,
    required this.totalPage,
    required this.creditId,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "page": page,
      "total_page": totalPage,
      "credit_id": creditId,
    };
    return data;
  }

  @override
  List<Object?> get props => [page, totalPage];
}

class UpdateCreditParams extends Equatable {
  final String uid;
  final int creditId;
  final int id;
  final String typePayment;
  final String accountId;
  const UpdateCreditParams({
    required this.uid,
    required this.creditId,
    required this.id,
    required this.typePayment,
    required this.accountId,
  });
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "credit_id": creditId,
      "id": id,
      "type_payment": typePayment,
      "account_id": accountId,
    };
  }

  @override
  List<Object?> get props => [];
}
