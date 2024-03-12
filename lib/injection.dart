import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

part 'injection/authentication_injection.dart';

final sl = GetIt.instance;

FutureOr<void> initContainer() async {
  authenticationInjection();

  sl.registerLazySingleton(() => Connectivity());

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  sl.registerLazySingleton(() => SecureStorageManager());

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
