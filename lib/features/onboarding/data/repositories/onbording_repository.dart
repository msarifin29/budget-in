// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:dio/dio.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, MonthlyReportResponse>> getMonthlyReport(String uid);
  Future<Either<Failure, MaxBudgetResponse>> getmaximumBudget(
      GetMaxBudgetparam param);
  Future<Either<Failure, UpdateBudgetResponse>> updateMaxBudget(
      UpdateMaxBudgetparam param);
  Future<Either<Failure, MonthlyReportDetailResponse>> monthlyReportDetail(
      MonthlyReportDetailParam param);
}

class OnboardingRepositoryImpl extends OnboardingRepository {
  final OnboardingRemoteDatasource remoteDataSource;
  final NetworkInfo networkInfo;
  OnboardingRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, MonthlyReportResponse>> getMonthlyReport(
      String uid) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final MonthlyReportResponse response =
            await remoteDataSource.getMonthlyReport(uid);
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
  Future<Either<Failure, MaxBudgetResponse>> getmaximumBudget(
      GetMaxBudgetparam param) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final MaxBudgetResponse response =
            await remoteDataSource.getMaximumBudget(param);
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
  Future<Either<Failure, UpdateBudgetResponse>> updateMaxBudget(
      UpdateMaxBudgetparam param) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final UpdateBudgetResponse response =
            await remoteDataSource.updateMaxBudget(param);
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
  Future<Either<Failure, MonthlyReportDetailResponse>> monthlyReportDetail(
      MonthlyReportDetailParam param) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final MonthlyReportDetailResponse response =
            await remoteDataSource.monthlyReportDetail(param);
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
