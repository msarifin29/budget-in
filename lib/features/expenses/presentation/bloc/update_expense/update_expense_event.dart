part of 'update_expense_bloc.dart';

sealed class UpdateExpenseEvent extends Equatable {
  const UpdateExpenseEvent();

  @override
  List<Object> get props => [];
}

final class CancelExpense extends UpdateExpenseEvent {
  const CancelExpense({
    required this.id,
    required this.expenseType,
    required this.accountId,
  });
  final int id;
  final String expenseType;
  final String accountId;
  @override
  List<Object> get props => [
        id,
        expenseType,
        accountId,
      ];
  @override
  String toString() {
    return 'CancelExpense{}';
  }
}
