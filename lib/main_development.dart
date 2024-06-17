import 'package:budget_in/bootstrap.dart';

import 'package:budget_in/features/app.dart';
import 'package:budget_in/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initContainer();
  // env
  await dotenv.load(fileName: ".env");

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  bootstrap(() => const App());
}
