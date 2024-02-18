import 'dart:async';

import 'package:budget_in/features/authentication/authentication.dart';
import 'package:get_it/get_it.dart';

part 'injection/authentication_injection.dart';

final sl = GetIt.instance;

FutureOr<void> initContainer() async {
  authenticationInjection();
}
