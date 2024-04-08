import 'package:budget_in/bootstrap.dart';

import 'package:budget_in/features/app.dart';
import 'package:budget_in/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initContainer();
  // env
  await dotenv.load(fileName: ".env");

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  bootstrap(() => const App());
}
