// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/incomes/incomes.dart';

class CreateIncomeUsecase implements UseCase<bool, CreateIncomeParams> {
  final IncomeRepository repository;

  CreateIncomeUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, bool>> call(CreateIncomeParams params) async {
    return await repository.create(params);
  }
}

class GetIncomesUsecase implements UseCase<GetIncomeResponse, GetIncomeParams> {
  final IncomeRepository repository;
  GetIncomesUsecase({
    required this.repository,
  });
  @override
  FutureOr<Either<Failure, GetIncomeResponse>> call(
      GetIncomeParams params) async {
    return await repository.getIncomes(params);
  }
}
