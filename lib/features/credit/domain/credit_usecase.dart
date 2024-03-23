// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:dartz/dartz.dart';

class CreateCreditUsecase
    implements UseCase<CreditResponse, CreateCreditParams> {
  final CreditRepository repository;
  CreateCreditUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, CreditResponse>> call(
      CreateCreditParams param) async {
    return repository.create(param);
  }
}

class GetCreditUsecase implements UseCase<GetCreditResponse, GetCreditParams> {
  final CreditRepository repository;
  GetCreditUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, GetCreditResponse>> call(
      GetCreditParams param) async {
    return repository.getCredits(param);
  }
}

class GetHistoriesUsecase implements UseCase<HistoryResponse, GetCreditParams> {
  final CreditRepository repository;
  GetHistoriesUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, HistoryResponse>> call(GetCreditParams param) async {
    return repository.getHistories(param);
  }
}
