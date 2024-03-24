part of 'create_credit_bloc.dart';

sealed class CreateCreditState extends Equatable {
  const CreateCreditState();

  @override
  List<Object> get props => [];
}

final class CreateCreditInitial extends CreateCreditState {}

final class CreateCreditLoading extends CreateCreditState {}

final class CreateCreditSuccess extends CreateCreditState {
  final CreditData response;
  const CreateCreditSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class CreateCreditFailure extends CreateCreditState {
  final String message;
  const CreateCreditFailure({required this.message});

  @override
  List<Object> get props => [message];
}
