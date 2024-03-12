part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  const LoginSuccess({required this.data});

  final DataLogin data;
  @override
  List<Object> get props => [data];

  @override
  String toString() {
    return 'LoginSuccess{data:$data}';
  }
}

final class LoginFailure extends LoginState {
  const LoginFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'LoginFailure{message:$message}';
  }
}
