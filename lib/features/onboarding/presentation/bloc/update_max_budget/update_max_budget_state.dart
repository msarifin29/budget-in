part of 'update_max_budget_bloc.dart';

sealed class UpdateMaxBudgetState extends Equatable {
  const UpdateMaxBudgetState();

  @override
  List<Object> get props => [];
}

final class UpdateMaxBudgetInitial extends UpdateMaxBudgetState {}

final class UpdateMaxBudgetLoading extends UpdateMaxBudgetState {}

final class UpdateMaxBudgetSuccess extends UpdateMaxBudgetState {
  final UpdateBudgetResponse response;
  const UpdateMaxBudgetSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class UpdateMaxBudgetFailure extends UpdateMaxBudgetState {
  final String message;

  const UpdateMaxBudgetFailure({required this.message});
  @override
  List<Object> get props => [message];
}
