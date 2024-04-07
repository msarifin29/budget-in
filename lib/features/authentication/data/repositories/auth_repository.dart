// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:dio/dio.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginResponse>> login(LoginParams params);
  Future<Either<Failure, LoginResponse>> register(RegisterParams params);
  Future<Either<Failure, AccountResponse>> account(String uid);
  Future<Either<Failure, DeleteResponse>> deleteAccount();
  Future<Either<Failure, DynamicResponse>> forgotPassword(
      ForgotPasswordParam param);
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, LoginResponse>> login(LoginParams params) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final LoginResponse response = await remoteDataSource.login(params);
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
  Future<Either<Failure, LoginResponse>> register(RegisterParams params) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final LoginResponse response = await remoteDataSource.register(params);
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
            errorResponseData.containsKey('errors')) {
          errorData = errorResponseData['errors'];
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
  Future<Either<Failure, AccountResponse>> account(String uid) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final AccountResponse response = await remoteDataSource.account(uid);
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
  Future<Either<Failure, DeleteResponse>> deleteAccount() async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final DeleteResponse response = await remoteDataSource.deleteAccount();
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
  Future<Either<Failure, DynamicResponse>> forgotPassword(
      ForgotPasswordParam param) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final DynamicResponse response =
            await remoteDataSource.forgotPassword(param);
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
