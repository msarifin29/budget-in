part of 'get_expenses_bloc.dart';

sealed class GetExpensesState extends Equatable {
  const GetExpensesState();

  @override
  List<Object> get props => [];
}

final class GetExpensesInitial extends GetExpensesState {}

final class GetExpensesLoading extends GetExpensesState {}

final class GetExpensesSuccess extends GetExpensesState {
  final GetExpenseData expenseData;
  const GetExpensesSuccess({required this.expenseData});
  @override
  List<Object> get props => [expenseData];
}

final class GetExpensesFailure extends GetExpensesState {
  final String message;
  const GetExpensesFailure({required this.message});
  @override
  List<Object> get props => [message];
}
