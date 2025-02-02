// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/incomes/incomes.dart';

abstract class IncomeRemoteDatasource {
  Future<bool> create(CreateIncomeParams params);
  Future<GetIncomeResponse> getIncomes(GetIncomeParams params);
}

class IncomeRemoteDatasourceImpl extends IncomeRemoteDatasource {
  final Dio dio;
  IncomeRemoteDatasourceImpl({
    required this.dio,
  });
  final baseUrl = dotenv.env['BASE_URL'];
  @override
  Future<bool> create(CreateIncomeParams params) async {
    final String path = '$baseUrl/api/incomes/create';
    final Response<dynamic> response = await dio.post(
      path,
      options: Options(
        headers: {BaseUrlConfig.requiredToken: true},
      ),
      data: params.toMap(),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<GetIncomeResponse> getIncomes(GetIncomeParams params) async {
    final String path = '$baseUrl/api/incomes';
    final Response<dynamic> response = await dio.get(
      path,
      options: Options(
        headers: {BaseUrlConfig.requiredToken: true},
      ),
      queryParameters: params.toMap(),
    );
    if (response.statusCode == 200) {
      return GetIncomeResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }
}

class CreateIncomeParams extends Equatable {
  final String uid;
  final String? categoryIncome;
  final int categoryId;
  final String typeIncome;
  final String total;
  final String accountId;
  final String? createdAt;
  final String? bankName;
  final String? bankId;
  const CreateIncomeParams({
    required this.uid,
    this.categoryIncome,
    required this.categoryId,
    required this.typeIncome,
    required this.total,
    required this.accountId,
    this.createdAt,
    this.bankName,
    this.bankId,
  });
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "uid": uid,
      "category_id": categoryId,
      "type_income": typeIncome,
      "total": int.parse(total.replaceAll(RegExp(r'[^0-9]'), '')),
      "account_id": accountId,
    };
    if (categoryIncome != null) data["category_income"] = categoryIncome;
    if (createdAt != null) data["created_at"] = createdAt;
    if (bankName != null) data["bank_name"] = bankName;
    if (bankId != null) data["bank_id"] = bankId;
    return data;
  }

  @override
  List<Object?> get props => [
        uid,
        categoryId,
        typeIncome,
        total,
        accountId,
        categoryIncome,
        createdAt,
        bankName,
        bankId
      ];
}

class GetIncomeParams extends Equatable {
  final String? typeIncome;
  final int? categoryId;
  final int? page;
  const GetIncomeParams({
    this.typeIncome,
    this.categoryId,
    this.page,
  });

  GetIncomeParams copyWith({
    String? typeIncome,
    int? categoryId,
    int? page,
  }) =>
      GetIncomeParams(
        page: page ?? this.page,
        categoryId: this.categoryId,
        typeIncome: typeIncome ?? this.typeIncome,
      );

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "total_page": 10,
    };
    if (typeIncome != null) data["type_income"] = typeIncome;
    if (categoryId != null) data["category_id"] = categoryId;
    if (page != null) data["page"] = page;
    return data;
  }

  @override
  List<Object?> get props => [typeIncome, categoryId, page];
}
