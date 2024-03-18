// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/data/repositories/onbording_repository.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:dartz/dartz.dart';

class GetOnboardingUsecase implements UseCase<MonthlyReportResponse, NoParams> {
  final OnboardingRepository repository;
  GetOnboardingUsecase({
    required this.repository,
  });

  @override
  FutureOr<Either<Failure, MonthlyReportResponse>> call(NoParams param) async {
    return repository.getMonthlyReport();
  }
}
