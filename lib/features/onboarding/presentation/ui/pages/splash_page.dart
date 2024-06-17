import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = RouteName.initialPage;
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthUserCubit, AuthUserState>(
      listener: (context, state) {
        if (state is AuthUserFailure) {
          Future.delayed(const Duration(seconds: 2)).then((_) =>
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginPage.routeName, (route) => false));
        }
        if (state is AuthUserLoaded) {
          Future.delayed(const Duration(seconds: 2)).then((_) =>
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return const MainPage(currentIndex: 0);
              }), (route) => false));
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: const LogoWidget()),
          ],
        ),
      ),
    );
  }
}
