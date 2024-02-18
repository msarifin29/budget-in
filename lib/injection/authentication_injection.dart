// ignore_for_file: unnecessary_lambdas, cascade_invocations

part of '../injection.dart';

FutureOr<void> authenticationInjection() async {
  // DataSource
  sl.registerLazySingleton<CityLocaleDataSource>(
    () => CityLocaleDataSourceImpl(),
  );
  sl.registerLazySingleton<OccupationLocaleDataSource>(
    () => OccupationLocaleDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<CityRepository>(
    () => CityRepositoryImpl(
      localeDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<OccupationRepository>(
    () => OccupationRepositoryImpl(
      localeDataSource: sl(),
    ),
  );

  // Usecase
  sl.registerLazySingleton(() => GetCities(repository: sl()));
  sl.registerLazySingleton(() => GetOccupations(repository: sl()));

  // Bloc
  sl.registerFactory(() => CityBloc(getCities: sl()));
  sl.registerFactory(() => OccupationBloc(getOccupations: sl()));
}
