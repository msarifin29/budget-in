import 'dart:developer';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class ExpenseRemoteDataSource {
  Future<Expenseresponse> create(Expenseparams params);
  Future<GetExpenseResponse> getExpenses(GetExpensesparams params);
}

class ExpenseRemoteDataSourceImpl extends ExpenseRemoteDataSource {
  final Dio dio;

  ExpenseRemoteDataSourceImpl({required this.dio});
  final baseUrl = dotenv.env['BASE_URL'];
  @override
  Future<Expenseresponse> create(Expenseparams params) async {
    final String path = '$baseUrl/api/expenses/create';
    final Response<dynamic> response = await dio.post(path,
        data: params.toMap(),
        options: Options(headers: {BaseUrlConfig.requiredToken: true}));
    log('create expenses datasource ${response.data}');
    if (response.statusCode == 200) {
      return Expenseresponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }

  @override
  Future<GetExpenseResponse> getExpenses(GetExpensesparams params) async {
    final String path = '$baseUrl/api/expenses';
    final Response<dynamic> response = await dio.get(
      path,
      options: Options(headers: {BaseUrlConfig.requiredToken: true}),
      queryParameters: params.toMap(),
    );
    if (response.statusCode == 200) {
      return GetExpenseResponse.fromJson(response.data);
    } else {
      throw DioException(
        requestOptions: RequestOptions(path: path),
      );
    }
  }
}

class Expenseparams extends Equatable {
  final String uid;
  final String expenseType;
  final String total;
  final String category;
  final String accountId;

  const Expenseparams(
      {required this.uid,
      required this.expenseType,
      required this.total,
      required this.category,
      required this.accountId});

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "expense_type": expenseType,
      "total": int.parse(total.replaceAll(RegExp(r'[^0-9]'), '')),
      "category": category,
      "account_id": accountId,
    };
  }

  @override
  List<Object?> get props => [
        uid,
        expenseType,
        total,
        category,
        accountId,
      ];
}

class GetExpensesparams extends Equatable {
  final int page;
  final int totalPage;
  final String? expenseType;
  final String status;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {};
    data['page'] = page;
    data['total_page'] = totalPage;
    data['status'] = status;
    if (expenseType != null) data['expense_type'] = expenseType;
    return data;
  }

  GetExpensesparams copyWith({
    int? page,
    int? totalPage,
    String? expenseType,
    String? status,
  }) {
    return GetExpensesparams(
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
      status: status ?? this.status,
      expenseType: expenseType ?? this.expenseType,
    );
  }

  const GetExpensesparams(
      {required this.page,
      required this.totalPage,
      this.expenseType,
      required this.status});
  @override
  List<Object?> get props => throw UnimplementedError();
}
