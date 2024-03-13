part of 'account_bloc.dart';

sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitial extends AccountState {}

final class AccountLoading extends AccountState {}

final class AccountSuccess extends AccountState {
  final AccountData accountData;
  const AccountSuccess({required this.accountData});

  @override
  List<Object> get props => [accountData];
  @override
  String toString() {
    return 'AccountSuccess{accountData:$accountData}';
  }
}

final class AccountFailre extends AccountState {
  final String message;
  const AccountFailre({required this.message});

  @override
  List<Object> get props => [message];
  @override
  String toString() {
    return 'AccountFailre{message:$message}';
  }
}
