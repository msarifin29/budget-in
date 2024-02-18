// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/data/authentication_data.dart';
import 'package:dartz/dartz.dart';

class GetCities implements UseCase<List<String>, NoParams> {
  final CityRepository repository;
  GetCities({required this.repository});

  @override
  FutureOr<Either<Failure, List<String>>> call(NoParams param) {
    return repository.getCities();
  }
}
