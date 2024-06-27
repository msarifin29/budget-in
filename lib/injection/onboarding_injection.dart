part of '../injection.dart';

FutureOr<void> onboardingInjection() async {
  // DataSource
  sl.registerLazySingleton<OnboardingRemoteDatasource>(
    () => OnboardingRemoteDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<OnboardingRepository>(() => OnboardingRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton(() => GetOnboardingUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetMaxBudgetUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateMaxBudgetUsecase(repository: sl()));
  sl.registerLazySingleton(() => MonthlyReportDetailUsecase(repository: sl()));
  sl.registerLazySingleton(
      () => MonthlyReportCategoryUsecase(repository: sl()));
  // Bloc
  sl.registerLazySingleton(() => GetMonthlyReportBloc(usecase: sl()));
  sl.registerLazySingleton(() => MonthlyReportDetailBloc(usecase: sl()));
  sl.registerLazySingleton(() => MonthlyReportCategoryBloc(usecase: sl()));
  sl.registerLazySingleton(() => MonthlyReportDashboardBloc(usecase: sl()));
}
