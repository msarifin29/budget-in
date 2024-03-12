part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class OnUserLogin extends LoginEvent {
  final String email;
  final String password;
  const OnUserLogin({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
  @override
  String toString() {
    return 'OnUserLogin{email:$email, password:$password}';
  }
}
