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
}
