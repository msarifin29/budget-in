part of '../injection.dart';

FutureOr<void> creditInjection() async {
  // DataSource
  sl.registerLazySingleton<CreditRemoteDatasource>(
    () => CreditRemoteDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<CreditRepository>(() => CreditRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton(() => CreateCreditUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetCreditUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetHistoriesUsecase(repository: sl()));
  sl.registerLazySingleton(() => PayCreditUsecase(repository: sl()));
}
