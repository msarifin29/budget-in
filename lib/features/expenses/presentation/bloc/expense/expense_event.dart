part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

final class CreateExpenseEvent extends ExpenseEvent {
  const CreateExpenseEvent({
    required this.uid,
    required this.expenseType,
    required this.total,
    this.category,
    required this.categoryId,
    required this.accountId,
    this.notes,
  });
  final String uid;
  final String expenseType;
  final String total;
  final String? category;
  final int categoryId;
  final String accountId;
  final String? notes;
  @override
  List<Object> get props => [
        uid,
        expenseType,
        total,
        category!,
        categoryId,
        accountId,
        notes!,
      ];
  @override
  String toString() {
    return 'CreateExpenseEvent{uid:$uid, expenseType:$expenseType, total:$total, category:$category, categoryId:$categoryId, accountId:$accountId, notes:$notes,}';
  }
}
