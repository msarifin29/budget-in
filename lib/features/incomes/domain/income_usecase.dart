import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:dartz/dartz.dart';

class CreateIncomeUsecase
    implements UseCase<IncomeResponse, CreateIncomeParams> {
  final IncomeRepository repository;

  CreateIncomeUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, IncomeResponse>> call(
      CreateIncomeParams params) async {
    return await repository.create(params);
  }
}
