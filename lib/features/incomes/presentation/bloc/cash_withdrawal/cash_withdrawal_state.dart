part of 'cash_withdrawal_bloc.dart';

sealed class CashWithdrawalState extends Equatable {
  const CashWithdrawalState();

  @override
  List<Object> get props => [];
}

final class CashWithdrawalInitial extends CashWithdrawalState {}

final class CashWithdrawalLoading extends CashWithdrawalState {}

final class CashWithdrawalSuccess extends CashWithdrawalState {}

final class CashWithdrawalFailure extends CashWithdrawalState {
  const CashWithdrawalFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
