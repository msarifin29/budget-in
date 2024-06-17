import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final CreateExpenseUsecase createExpenseUsecase;
  ExpenseBloc({required this.createExpenseUsecase}) : super(ExpenseInitial()) {
    on<CreateExpenseEvent>(createExpense);
  }

  FutureOr<void> createExpense(
      CreateExpenseEvent event, Emitter<ExpenseState> emit) async {
    emit(CreateExpenseLoading());
    final result = await createExpenseUsecase(
      Expenseparams(
        uid: event.uid,
        expenseType: event.expenseType,
        total: event.total,
        category: event.category,
        categoryId: event.categoryId,
        accountId: event.accountId,
        notes: event.notes,
        createdAt: event.createdAt,
        bankName: event.bankName,
        bankId: event.bankId,
      ),
    );
    emit(result.fold((l) {
      var message = '';
      if (l is ServerFailure) {
        message = l.failure.message ?? '';
      } else if (l is ConnectionFailure) {
        message = 'Connection Faiure';
      } else if (l is ParsingFailure) {
        debugPrint(message = l.message);
      }
      return CreateExpenseFailure(message: message);
    }, (r) => CreateExpenseSuccess(expenseData: r)));
  }
}
