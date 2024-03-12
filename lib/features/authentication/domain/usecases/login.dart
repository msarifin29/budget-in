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
