// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:dartz/dartz.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';

class GetOnboardingUsecase implements UseCase<MonthlyReportResponse, String> {
  final OnboardingRepository repository;
  GetOnboardingUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, MonthlyReportResponse>> call(String uid) async {
    return repository.getMonthlyReport(uid);
  }
}

class GetMaxBudgetUsecase implements UseCase<MaxBudgetResponse, NoParams> {
  final OnboardingRepository repository;
  GetMaxBudgetUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, MaxBudgetResponse>> call(NoParams params) async {
    return repository.getmaximumBudget();
  }
}

class UpdateMaxBudgetUsecase
    implements UseCase<UpdateBudgetResponse, UpdateMaxBudgetparam> {
  final OnboardingRepository repository;
  UpdateMaxBudgetUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, UpdateBudgetResponse>> call(
      UpdateMaxBudgetparam params) async {
    return repository.updateMaxBudget(params);
  }
}
