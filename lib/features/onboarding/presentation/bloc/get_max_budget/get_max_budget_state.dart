part of 'get_max_budget_bloc.dart';

sealed class GetMaxBudgetState extends Equatable {
  const GetMaxBudgetState();

  @override
  List<Object> get props => [];
}

final class GetMaxBudgetInitial extends GetMaxBudgetState {}

final class GetMaxBudgetLoading extends GetMaxBudgetState {}

final class GetMaxBudgetSuccess extends GetMaxBudgetState {
  final MaxBudgetResponse response;
  const GetMaxBudgetSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class GetMaxBudgetFailure extends GetMaxBudgetState {
  final String message;
  const GetMaxBudgetFailure({required this.message});
  @override
  List<Object> get props => [message];
}
