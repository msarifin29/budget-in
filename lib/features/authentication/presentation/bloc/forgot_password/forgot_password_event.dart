part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class OnReset extends ForgotPasswordEvent {
  const OnReset({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
}
