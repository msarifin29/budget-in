// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:dio/dio.dart';

abstract class IncomeRepository {
  Future<Either<Failure, IncomeResponse>> create(CreateIncomeParams params);
  Future<Either<Failure, GetIncomeResponse>> getIncomes(GetIncomeParams params);
}

class IncomeRepositoryImpl extends IncomeRepository {
  final IncomeRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;
  IncomeRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, IncomeResponse>> create(
      CreateIncomeParams params) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final IncomeResponse response = await remoteDataSource.create(params);
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

  @override
  Future<Either<Failure, GetIncomeResponse>> getIncomes(
      GetIncomeParams params) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final GetIncomeResponse response =
            await remoteDataSource.getIncomes(params);
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
