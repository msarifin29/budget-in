import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection/authentication_injection.dart';

final sl = GetIt.instance;

FutureOr<void> initContainer() async {
  authenticationInjection();

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
