part of 'pay_credit_bloc.dart';

sealed class PayCreditEvent extends Equatable {
  const PayCreditEvent();

  @override
  List<Object> get props => [];
}

final class InitialPaymentEvent extends PayCreditEvent {
  const InitialPaymentEvent({required this.params});
  final UpdateCreditParams params;
  @override
  List<Object> get props => [];
}
