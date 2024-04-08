part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

final class InitialReset extends ResetPasswordEvent {
  const InitialReset({
    required this.oldPassword,
    required this.newPassword,
  });
  final String oldPassword;
  final String newPassword;
  @override
  List<Object> get props => [oldPassword, newPassword];
}
