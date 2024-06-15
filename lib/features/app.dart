import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/new_bloc.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  void dispose() {
    AuthUserCubit().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthUserCubit()..tokenIsExist(),
      child: NewBloc(
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
              if (state is AuthUserFailure) {
                return const LoginPage();
              }
              if (state is AuthUserLoaded) {
                return const MainPage(currentIndex: 0);
              }
              return const LoginPage();
            },
          ),
        ),
      ),
    );
  }
}
