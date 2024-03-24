import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/credit/credits.dart';
import 'features/onboarding/onboarding.dart';

part 'injection/expense_injection.dart';
part 'injection/authentication_injection.dart';
part 'injection/onboarding_injection.dart';
part 'injection/income_injection.dart';
part 'injection/credit_injection.dart';

final sl = GetIt.instance;

FutureOr<void> initContainer() async {
  authenticationInjection();
  expenseInjection();
  onboardingInjection();
  incomeInjection();
  creditInjection();

  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => SecureStorageManager());
  final sharedPreferences = await SharedPreferences.getInstance();
  final sharedPreferencesManager =
      SharedPreferencesManager.getInstance(sharedPreferences);
  sl.registerLazySingleton(() => sharedPreferencesManager);

  sl.registerLazySingleton(() {
    final options = BaseOptions(
      connectTimeout: (const Duration(milliseconds: 20 * 1000)), //20 seconds
      receiveTimeout: (const Duration(milliseconds: 20 * 1000)),
    );
    final dio = Dio(options);
    dio.interceptors.add(DioLoggingInterceptor(dio, sl()));
    return dio;
  });
}
