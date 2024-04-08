part of 'reset_password_bloc.dart';

sealed class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object> get props => [];
}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {}

final class ResetPasswordSuccess extends ResetPasswordState {
  final DynamicResponse response;
  const ResetPasswordSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class ResetPasswordFailure extends ResetPasswordState {
  final String message;
  const ResetPasswordFailure({required this.message});
  @override
  List<Object> get props => [message];
}
