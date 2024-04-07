part of 'update_max_budget_bloc.dart';

sealed class UpdateMaxBudgetEvent extends Equatable {
  const UpdateMaxBudgetEvent();

  @override
  List<Object> get props => [];
}

final class OnUpdated extends UpdateMaxBudgetEvent {
  const OnUpdated({required this.param});
  final UpdateMaxBudgetparam param;
  @override
  List<Object> get props => [param];
}
