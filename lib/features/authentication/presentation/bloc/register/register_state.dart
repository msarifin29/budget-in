part of 'register_bloc.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  const RegisterSuccess({required this.data});

  final DataLogin data;
  @override
  List<Object> get props => [data];

  @override
  String toString() {
    return 'RegisterSuccess{data:$data}';
  }
}

final class RegisterFailure extends RegisterState {
  const RegisterFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'RegisterFailure{message:$message}';
  }
}

final class ExistingEmailLoading extends RegisterState {}

final class ExistingEmailSuccess extends RegisterState {
  const ExistingEmailSuccess({required this.isExist});

  final bool isExist;
  @override
  List<Object> get props => [isExist];

  @override
  String toString() {
    return 'ExistingEmailSuccess{isExist:$isExist}';
  }
}

final class ExistingEmailFailure extends RegisterState {
  const ExistingEmailFailure({required this.message});
  final String message;

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'ExistingEmailFailure{message:$message}';
  }
}
