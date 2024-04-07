part of 'get_max_budget_bloc.dart';

sealed class GetMaxBudgetEvent extends Equatable {
  const GetMaxBudgetEvent();

  @override
  List<Object> get props => [];
}

final class InitialData extends GetMaxBudgetEvent {
  final String accountId;
  final String uid;

  const InitialData({required this.accountId, required this.uid});
  @override
  List<Object> get props => [accountId, uid];
}
