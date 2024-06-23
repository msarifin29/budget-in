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

class GetMaxBudgetUsecase
    implements UseCase<MaxBudgetResponse, GetMaxBudgetparam> {
  final OnboardingRepository repository;
  GetMaxBudgetUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, MaxBudgetResponse>> call(
      GetMaxBudgetparam param) async {
    return repository.getmaximumBudget(param);
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

class MonthlyReportDetailUsecase
    implements UseCase<MonthlyReportDetailResponse, MonthlyReportDetailParam> {
  final OnboardingRepository repository;
  MonthlyReportDetailUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, MonthlyReportDetailResponse>> call(
      MonthlyReportDetailParam params) async {
    return repository.monthlyReportDetail(params);
  }
}

class MonthlyReportCategoryUsecase
    implements
        UseCase<MonthlyReportCategoryResponse, MonthlyReportDetailParam> {
  final OnboardingRepository repository;
  MonthlyReportCategoryUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, MonthlyReportCategoryResponse>> call(
      MonthlyReportDetailParam params) async {
    return repository.monthlyReportCategory(params);
  }
}
