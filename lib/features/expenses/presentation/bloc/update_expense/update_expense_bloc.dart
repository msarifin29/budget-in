import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:equatable/equatable.dart';

part 'update_expense_event.dart';
part 'update_expense_state.dart';

class UpdateExpenseBloc extends Bloc<UpdateExpenseEvent, UpdateExpenseState> {
  final UpdateExpensesUsecase usecase;
  UpdateExpenseBloc({required this.usecase}) : super(UpdateExpenseInitial()) {
    on<CancelExpense>((event, emit) async {
      emit(UpdateExpenseLoading());
      final result = await usecase(UpdateExpenseParams(
        id: event.id,
        expenseType: event.expenseType,
        accountId: event.accountId,
      ));
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          log(message = l.message);
        }
        return UpdateExpenseFailure(message: message);
      }, (r) => UpdateExpenseSuccess(response: r)));
    });
  }
}
