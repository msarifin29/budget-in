import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:dartz/dartz.dart';

class CreateExpenseUsecase implements UseCase<Expenseresponse, Expenseparams> {
  final ExpenseRepository repository;

  CreateExpenseUsecase({required this.repository});
  @override
  FutureOr<Either<Failure, Expenseresponse>> call(Expenseparams params) async {
    return repository.create(params);
  }
}
