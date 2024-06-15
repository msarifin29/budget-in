part of 'auth_user_cubit.dart';

sealed class AuthUserState extends Equatable {
  const AuthUserState();

  @override
  List<Object> get props => [];
}

final class AuthUserInitial extends AuthUserState {}

final class AuthUserLoading extends AuthUserState {}

final class AuthUserLoaded extends AuthUserState {
  const AuthUserLoaded();
}

final class AuthUserFailure extends AuthUserState {
  const AuthUserFailure();
}
