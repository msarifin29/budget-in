// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/data/datasources/auth_remote_datasource.dart';

class LoginUsecase implements UseCase<LoginResponse, LoginParams> {
  final AuthRepository repository;
  LoginUsecase({
    required this.repository,
  });
  @override
  FutureOr<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return repository.login(params);
  }
}

class RegisterUsecase implements UseCase<LoginResponse, RegisterParams> {
  final AuthRepository repository;
  RegisterUsecase({required this.repository});
  @override
  FutureOr<Either<Failure, LoginResponse>> call(RegisterParams params) async {
    return repository.register(params);
  }
}

class AccountUsecase implements UseCase<AccountResponse, String> {
  final AuthRepository repository;

  AccountUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, AccountResponse>> call(String param) async {
    return await repository.account(param);
  }
}

class DeleteAccountUsecase implements UseCase<DeleteResponse, NoParams> {
  final AuthRepository repository;

  DeleteAccountUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, DeleteResponse>> call(NoParams param) async {
    return await repository.deleteAccount();
  }
}

class ForgotPasswordUsecase
    implements UseCase<DynamicResponse, ForgotPasswordParam> {
  final AuthRepository repository;

  ForgotPasswordUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, DynamicResponse>> call(
      ForgotPasswordParam param) async {
    return await repository.forgotPassword(param);
  }
}

class ResetPasswordUsecase
    implements UseCase<DynamicResponse, ResetPasswordParam> {
  final AuthRepository repository;

  ResetPasswordUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, DynamicResponse>> call(
      ResetPasswordParam param) async {
    return await repository.resetPassword(param);
  }
}

class ExistingEmailUsecase implements UseCase<DynamicResponse, String> {
  final AuthRepository repository;

  ExistingEmailUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, DynamicResponse>> call(String param) async {
    return await repository.checkEmail(param);
  }
}
