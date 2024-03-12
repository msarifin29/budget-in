import 'dart:developer';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/presentation/ui/pages/onboarding_page.dart';
import 'package:budget_in/features/onboarding/presentation/ui/pages/main_page.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthUserCubit()..tokenIsExist(),
      child: MaterialApp(
        theme: lightTheme(),
        darkTheme: darkTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        navigatorKey: navigatorKey,
        onGenerateRoute: AppRoute.generateRoute,
        home: BlocBuilder<AuthUserCubit, AuthUserState>(
          builder: (context, state) {
            log('auth-user => $state');
            if (state is AuthUserLoaded) {
              if (state.isExist) {
                return const MainPage(currentIndex: 0);
              }
              return const OnboardingPage();
            }
            return const OnboardingPage();
          },
        ),
      ),
    );
  }
}
