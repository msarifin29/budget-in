part of 'pay_credit_bloc.dart';

sealed class PayCreditState extends Equatable {
  const PayCreditState();

  @override
  List<Object> get props => [];
}

final class PayCreditInitial extends PayCreditState {}

final class PayCreditLoading extends PayCreditState {}

final class PayCreditSuccess extends PayCreditState {
  final PayCreditData data;
  const PayCreditSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class PayCreditFailure extends PayCreditState {
  final String message;
  const PayCreditFailure({required this.message});
  @override
  List<Object> get props => [message];
}
