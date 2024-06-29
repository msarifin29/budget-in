part of '../injection.dart';

FutureOr<void> incomeInjection() async {
  sl.registerLazySingleton<IncomeRemoteDatasource>(
    () => IncomeRemoteDatasourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<IncomeRepository>(() => IncomeRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton(() => CreateIncomeUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetIncomesUsecase(repository: sl()));

  sl.registerLazySingleton(() => CreateIncomeBloc(usecase: sl()));
  sl.registerLazySingleton(() => GetIncomeBloc(usecase: sl()));
}
