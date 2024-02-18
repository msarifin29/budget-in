import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/data/authentication_data.dart';
import 'package:dartz/dartz.dart';

class GetOccupations implements UseCase<List<String>, NoParams> {
  GetOccupations({required this.repository});
  final OccupationRepository repository;

  @override
  FutureOr<Either<Failure, List<String>>> call(NoParams param) {
    return repository.getOccupations();
  }
}
