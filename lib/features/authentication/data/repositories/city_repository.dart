// ignore_for_file: public_member_api_docs, sort_constructors_first, one_member_abstracts, lines_longer_than_80_chars
import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/data/authentication_data.dart';
import 'package:dartz/dartz.dart';

abstract class CityRepository {
  FutureOr<Either<Failure, List<String>>> getCities();
}

class CityRepositoryImpl implements CityRepository {
  final CityLocaleDataSource localeDataSource;
  CityRepositoryImpl({
    required this.localeDataSource,
  });

  @override
  FutureOr<Either<Failure, List<String>>> getCities() async {
    try {
      final cities = await localeDataSource.getCities();
      return Right(cities);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed parsing city'));
    }
  }
}
