// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  ServerFailure(this.failure);

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
  @override
  List<Object?> get props => [];
}

class ParsingFailure extends Failure {
  final String message;
  ParsingFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class ErrorResponseFailure extends Failure {
  ErrorResponseFailure({
    required this.errorResponse,
  });
  final ErrorResponse errorResponse;

  @override
  List<Object?> get props => [errorResponse];

  @override
  String toString() => "ErrorResponseFailure{errorResponse: $errorResponse}";
}

class ErrorResponse extends Equatable {
  final int? code;
  final String? message;
  const ErrorResponse({this.code, this.message});
  @override
  List<Object?> get props => [code, message];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'code': code,
      'message': message,
    };
  }

  factory ErrorResponse.fromMap(Map<dynamic, dynamic> map) {
    return ErrorResponse(
      code: map['code'] != null ? map['code'] as int : null,
      message: map['message'] != null ? map['message'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorResponse.fromJson(String source) =>
      ErrorResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
