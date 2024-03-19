part of 'get_income_bloc.dart';

sealed class GetIncomeState extends Equatable {
  const GetIncomeState();

  @override
  List<Object> get props => [];
}

final class GetIncomeInitial extends GetIncomeState {}

final class GetIncomeLoading extends GetIncomeState {}

final class GetIncomeSuccess extends GetIncomeState {
  final GetIncomeData data;

  const GetIncomeSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class GetIncomeFailure extends GetIncomeState {
  final String message;

  const GetIncomeFailure({required this.message});
  @override
  List<Object> get props => [message];
}
