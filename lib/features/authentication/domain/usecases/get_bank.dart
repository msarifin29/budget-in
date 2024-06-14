// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:dartz/dartz.dart';

class GetBank implements UseCase<List<BankModel>, NoParams> {
  final BankRepository repository;
  GetBank({required this.repository});

  @override
  FutureOr<Either<Failure, List<BankModel>>> call(NoParams param) {
    return repository.getCities();
  }
}
