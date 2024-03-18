part of '../injection.dart';

FutureOr<void> expenseInjection() async {
  // DataSource
  sl.registerLazySingleton<ExpenseRemoteDataSource>(
    () => ExpenseRemoteDataSourceImpl(dio: sl()),
  );
  sl.registerLazySingleton<ExpenseRepository>(() => ExpenseRepositoryImpl(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton(() => CreateExpenseUsecase(repository: sl()));
  sl.registerLazySingleton(() => GetExpensesUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdateExpensesUsecase(repository: sl()));
}
