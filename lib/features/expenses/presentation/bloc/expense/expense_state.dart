part of 'expense_bloc.dart';

sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

final class ExpenseInitial extends ExpenseState {}

final class CreateExpenseLoading extends ExpenseState {}

final class CreateExpenseSuccess extends ExpenseState {
  final bool expenseData;
  const CreateExpenseSuccess({required this.expenseData});

  @override
  List<Object> get props => [expenseData];
}

final class CreateExpenseFailure extends ExpenseState {
  const CreateExpenseFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
  @override
  String toString() {
    return 'CreateExpenseFailure{message:$message}';
  }
}
