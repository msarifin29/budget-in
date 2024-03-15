part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

final class CreateExpenseEvent extends ExpenseEvent {
  const CreateExpenseEvent(
      {required this.uid,
      required this.expenseType,
      required this.total,
      required this.category,
      required this.accountId});
  final String uid;
  final String expenseType;
  final String total;
  final String category;
  final String accountId;
  @override
  List<Object> get props => [
        uid,
        expenseType,
        total,
        category,
        accountId,
      ];
  @override
  String toString() {
    return 'CreateExpenseEvent{uid:$uid, expenseType:$expenseType, total:$total, category:$category, accountId:$accountId,}';
  }
}
