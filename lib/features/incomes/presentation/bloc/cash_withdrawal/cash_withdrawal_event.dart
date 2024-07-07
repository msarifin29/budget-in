part of 'cash_withdrawal_bloc.dart';

sealed class CashWithdrawalEvent extends Equatable {
  const CashWithdrawalEvent();

  @override
  List<Object> get props => [];
}

final class Withdraw extends CashWithdrawalEvent {
  const Withdraw({required this.total});
  final String total;

  @override
  List<Object> get props => [total];
}
