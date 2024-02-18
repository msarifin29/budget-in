import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/presentation/ui/authentication_ui.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoute.generateRoute,
      home: const SplashPage(),
    );
  }
}
