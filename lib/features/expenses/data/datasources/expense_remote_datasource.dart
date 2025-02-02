// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/expenses.dart';

abstract class ExpenseRemoteDataSource {
  Future<bool> create(Expenseparams params);
  Future<GetExpenseResponse> getExpenses(GetExpensesparams params);
  Future<UpdateExpenseResponse> updateExpense(UpdateExpenseParams params);
}

class ExpenseRemoteDataSourceImpl extends ExpenseRemoteDataSource {
  final Dio dio;

  ExpenseRemoteDataSourceImpl({required this.dio});
  final baseUrl = dotenv.env['BASE_URL'];
  @override
  Future<bool> create(Expenseparams params) async {
    final String path = '$baseUrl/api/expenses/create';
    final Response<dynamic> response = await dio.post(path,
        data: params.toMap(),
        options: Options(headers: {BaseUrlConfig.requiredToken: true}));
    if (response.statusCode == 200) {
      return true;
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

  @override
  Future<UpdateExpenseResponse> updateExpense(
      UpdateExpenseParams params) async {
    final String path = '$baseUrl/api/expenses/update';
    final Response<dynamic> response = await dio.put(
      path,
      options: Options(headers: {
        BaseUrlConfig.requiredToken: true,
      }),
      data: params.toMap(),
    );
    if (response.statusCode == 200) {
      return UpdateExpenseResponse.fromJson(response.data);
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
  final String? category;
  final int categoryId;
  final String accountId;
  final String? notes;
  final String? createdAt;
  final String? bankName;
  final String? bankId;

  const Expenseparams({
    required this.uid,
    required this.expenseType,
    required this.total,
    this.category,
    required this.categoryId,
    required this.accountId,
    this.notes,
    this.createdAt,
    this.bankName,
    this.bankId,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      "uid": uid,
      "expense_type": expenseType,
      "total": int.parse(total.replaceAll(RegExp(r'[^0-9]'), '')),
      "category_id": categoryId,
      "account_id": accountId,
    };
    if (category != null) data["category"] = category;
    if (notes != null) data["notes"] = notes;
    if (createdAt != null) data["created_at"] = createdAt;
    if (bankName != null) data["bank_name"] = bankName;
    if (bankId != null) data["bank_id"] = bankId;
    return data;
  }

  @override
  List<Object?> get props => [
        uid,
        expenseType,
        total,
        category,
        accountId,
        bankName,
        bankId,
      ];
}

class GetExpensesparams extends Equatable {
  final int? page;
  final int? totalPage;
  final String? expenseType;
  final String? status;
  final int? id;
  final String? createdAt;
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'status': 'success',
      'total_page': 10,
    };
    if (page != null) data['page'] = page;
    if (expenseType != null) data['expense_type'] = expenseType;
    if (id != null) data['id'] = id;
    if (createdAt != null) data['created_at'] = createdAt;
    return data;
  }

  GetExpensesparams copyWith(
      {int? page,
      int? totalPage,
      String? expenseType,
      String? status,
      int? id,
      String? createdAt}) {
    return GetExpensesparams(
      page: page ?? this.page,
      totalPage: totalPage ?? this.totalPage,
      status: status ?? this.status,
      expenseType: expenseType ?? this.expenseType,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  const GetExpensesparams({
    this.page,
    this.totalPage,
    this.expenseType,
    this.status,
    this.id,
    this.createdAt,
  });
  @override
  List<Object?> get props => [
        page,
        totalPage,
        expenseType,
        status,
        id,
        createdAt,
      ];
}

class UpdateExpenseParams extends Equatable {
  final int id;
  final String expenseType;
  final String accountId;
  const UpdateExpenseParams({
    required this.id,
    required this.expenseType,
    required this.accountId,
  });
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "expense_type": expenseType,
      "account_id": accountId,
    };
  }

  @override
  List<Object?> get props => [id, expenseType, accountId];
}
