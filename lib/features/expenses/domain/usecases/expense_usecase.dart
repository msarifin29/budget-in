import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:dartz/dartz.dart';

class CreateExpenseUsecase implements UseCase<Expenseresponse, Expenseparams> {
  final ExpenseRepository repository;

  CreateExpenseUsecase({required this.repository});
  @override
  FutureOr<Either<Failure, Expenseresponse>> call(Expenseparams params) async {
    return await repository.create(params);
  }
}

class GetExpensesUsecase
    implements UseCase<GetExpenseResponse, GetExpensesparams> {
  final ExpenseRepository repository;

  GetExpensesUsecase({required this.repository});
  @override
  FutureOr<Either<Failure, GetExpenseResponse>> call(
      GetExpensesparams params) async {
    return await repository.getExpenses(params);
  }
}

class UpdateExpensesUsecase
    implements UseCase<UpdateExpenseResponse, UpdateExpenseParams> {
  final ExpenseRepository repository;

  UpdateExpensesUsecase({required this.repository});
  @override
  FutureOr<Either<Failure, UpdateExpenseResponse>> call(
      UpdateExpenseParams params) async {
    return await repository.updateExpense(params);
  }
}
