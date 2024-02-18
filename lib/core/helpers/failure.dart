// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class DataApiFailure extends Equatable {
  final int? code;
  final String? status;
  final String? message;

  const DataApiFailure({
    this.code,
    this.status,
    this.message,
  });

  @override
  List<Object?> get props => [
        code,
        status,
        message,
      ];
}

class ServerFailure extends Failure {
  final DataApiFailure failure;
  ServerFailure({required this.failure});

  @override
  List<Object?> get props => [failure];
}

class CacheFailure extends Failure {
  final String message;
  CacheFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ConnectionFailure extends Failure {
  final String message;
  ConnectionFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class ParsingFailure extends Failure {
  final String message;
  ParsingFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
