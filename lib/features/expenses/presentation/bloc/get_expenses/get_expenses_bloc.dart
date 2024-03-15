import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/helpers/failure.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:equatable/equatable.dart';

part 'get_expenses_event.dart';
part 'get_expenses_state.dart';

class GetExpensesBloc extends Bloc<GetExpensesEvent, GetExpensesState> {
  final GetExpensesUsecase getExpensesUsecase;
  GetExpensesBloc({required this.getExpensesUsecase})
      : super(GetExpensesInitial()) {
    on<OnGetInitialExpenses>(getExpenses);
  }
  FutureOr<void> getExpenses(
      OnGetInitialExpenses event, Emitter<GetExpensesState> emit) async {
    emit(GetExpensesLoading());
    final result = await getExpensesUsecase(
      GetExpensesparams(
        page: event.params.page,
        totalPage: event.params.totalPage,
        expenseType: event.params.expenseType,
        status: event.params.status,
      ),
    );
    emit(result.fold((l) {
      var message = '';
      if (l is ServerFailure) {
        message = l.failure.message ?? '';
      } else if (l is ConnectionFailure) {
        message = 'Connection Faiure';
      } else if (l is ParsingFailure) {
        log(message = l.message);
      }
      return GetExpensesFailure(message: message);
    }, (r) => GetExpensesSuccess(expenseData: r.data)));
  }
}
