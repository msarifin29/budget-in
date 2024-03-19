part of 'create_income_bloc.dart';

sealed class CreateIncomeEvent extends Equatable {
  const CreateIncomeEvent();

  @override
  List<Object> get props => [];
}

final class InitialCreateEvent extends CreateIncomeEvent {
  const InitialCreateEvent({
    required this.uid,
    this.categoryIcome,
    required this.categoryId,
    required this.typeIcome,
    required this.total,
    required this.accountId,
    this.createdAt,
  });
  final String uid;
  final String? categoryIcome;
  final int categoryId;
  final String typeIcome;
  final String total;
  final String accountId;
  final String? createdAt;
  @override
  List<Object> get props => [
        uid,
        categoryIcome!,
        typeIcome,
        total,
        accountId,
        createdAt!,
      ];
  @override
  String toString() {
    return 'InitialCreateEvent{}';
  }
}
