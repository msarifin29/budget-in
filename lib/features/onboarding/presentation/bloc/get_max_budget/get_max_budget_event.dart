part of 'get_max_budget_bloc.dart';

sealed class GetMaxBudgetEvent extends Equatable {
  const GetMaxBudgetEvent();

  @override
  List<Object> get props => [];
}

final class InitialData extends GetMaxBudgetEvent {}
