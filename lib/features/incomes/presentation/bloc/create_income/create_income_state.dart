part of 'create_income_bloc.dart';

sealed class CreateIncomeState extends Equatable {
  const CreateIncomeState();

  @override
  List<Object> get props => [];
}

final class CreateIncomeInitial extends CreateIncomeState {}

final class CreateIncomeLoading extends CreateIncomeState {}

final class CreateIncomeSuccess extends CreateIncomeState {
  final bool data;

  const CreateIncomeSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class CreateIncomeFailed extends CreateIncomeState {
  final String message;

  const CreateIncomeFailed({required this.message});
  @override
  List<Object> get props => [message];
}
