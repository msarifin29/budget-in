// ignore_for_file: one_member_abstracts

import 'dart:async';

import 'package:budget_in/core/helpers/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<T, P> {
  FutureOr<Either<Failure, T>> call(P param);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'NoParams()';
  }
}

class CacheException implements Exception {}

class ConnectionException implements Exception {}
