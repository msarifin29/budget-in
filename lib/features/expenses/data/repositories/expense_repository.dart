// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/data/datasources/expense_remote_datasource.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class ExpenseRepository {
  Future<Either<Failure, Expenseresponse>> create(Expenseparams params);
}

class ExpenseRepositoryImpl extends ExpenseRepository {
  final ExpenseRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ExpenseRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Expenseresponse>> create(Expenseparams params) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final Expenseresponse response = await remoteDataSource.create(params);
        return Right(response);
      } on DioException catch (error) {
        if (error.response == null) {
          return Left(
            ServerFailure(
              DataApiFailure(message: error.message),
            ),
          );
        }
        final errorResponseData = error.response?.data;
        dynamic errorData;
        String errorMessage = Helpers.getErrorMessageFromEndpoint(
          errorResponseData,
          error.message ?? '',
          error.response?.statusCode ?? 400,
        );
        if (errorResponseData is Map &&
            errorResponseData.containsKey('error')) {
          errorData = errorResponseData['error'];
        }
        return Left(
          ServerFailure(
            DataApiFailure(
              message: errorMessage,
              code: error.response?.statusCode,
              status: errorData,
            ),
          ),
        );
      } on TypeError catch (error) {
        return Left(ParsingFailure(error.toString()));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }
}
