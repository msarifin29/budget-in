// ignore_for_file: unnecessary_lambdas, cascade_invocations

part of '../injection.dart';

FutureOr<void> authenticationInjection() async {
  // DataSource
  sl.registerLazySingleton<BankLocaleDataSource>(
    () => BankLocaleDataSourceImpl(),
  );
  sl.registerLazySingleton<OccupationLocaleDataSource>(
    () => OccupationLocaleDataSourceImpl(),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(dio: sl()),
  );

  // Repository
  sl.registerLazySingleton<BankRepository>(
    () => BankRepositoryImpl(
      localeDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<OccupationRepository>(
    () => OccupationRepositoryImpl(
      localeDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), networkInfo: sl()),
  );

  // Usecase
  sl.registerLazySingleton(() => GetBank(repository: sl()));
  sl.registerLazySingleton(() => GetOccupations(repository: sl()));
  sl.registerLazySingleton(() => LoginUsecase(repository: sl()));
  sl.registerLazySingleton(() => RegisterUsecase(repository: sl()));
  sl.registerLazySingleton(() => AccountUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeleteAccountUsecase(repository: sl()));
  sl.registerLazySingleton(() => ForgotPasswordUsecase(repository: sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(repository: sl()));
  sl.registerLazySingleton(() => ExistingEmailUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetPrivacyUsecase(repository: sl()));

  // Bloc
  sl.registerFactory(() => BankBloc(getBank: sl()));
  sl.registerFactory(() => OccupationBloc(getOccupations: sl()));
  sl.registerFactory(() => RegisterBloc(
        registerUsecase: sl(),
        existingEmailUsecase: sl(),
      ));
  sl.registerFactory(() => PrivacyBloc(sl()));
}
