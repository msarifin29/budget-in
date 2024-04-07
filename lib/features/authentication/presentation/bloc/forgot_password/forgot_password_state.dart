part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgotPasswordInitial extends ForgotPasswordState {}

final class ForgotPasswordLoading extends ForgotPasswordState {}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  final DynamicResponse response;

  const ForgotPasswordSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class ForgotPasswordFailure extends ForgotPasswordState {
  final String message;

  const ForgotPasswordFailure({required this.message});
  @override
  List<Object> get props => [message];
}
