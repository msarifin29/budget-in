part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class OnUserRegister extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  final String balance;
  final String cash;

  const OnUserRegister(
      {required this.username,
      required this.email,
      required this.password,
      required this.balance,
      required this.cash});
  @override
  List<Object> get props => [username, email, password, balance, cash];
  @override
  String toString() {
    return 'OnUserRegister{username:$username, email:$email, password:$password, balance:$balance, cash:$cash,}';
  }
}

class ExistingEmail extends RegisterEvent {
  const ExistingEmail({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
  @override
  String toString() {
    return 'ExistingEmail{email:$email}';
  }
}
