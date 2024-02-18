// ignore_for_file: public_member_api_docs, sort_constructors_first, one_member_abstracts, lines_longer_than_80_chars
import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/data/authentication_data.dart';
import 'package:dartz/dartz.dart';

abstract class OccupationRepository {
  FutureOr<Either<Failure, List<String>>> getOccupations();
}

class OccupationRepositoryImpl implements OccupationRepository {
  final OccupationLocaleDataSource localeDataSource;
  OccupationRepositoryImpl({
    required this.localeDataSource,
  });

  @override
  FutureOr<Either<Failure, List<String>>> getOccupations() async {
    try {
      final cities = await localeDataSource.getOccupations();
      return Right(cities);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed parsing occupation'));
    }
  }
}
