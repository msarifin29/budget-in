part of 'delete_account_bloc.dart';

sealed class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

final class DeleteAccountInitial extends DeleteAccountState {}

final class DeleteAccountLoading extends DeleteAccountState {}

final class DeleteAccountSuccess extends DeleteAccountState {
  final DeleteResponse response;

  const DeleteAccountSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class DeleteAccountFailure extends DeleteAccountState {
  final String message;

  const DeleteAccountFailure({required this.message});
  @override
  List<Object> get props => [message];
}
