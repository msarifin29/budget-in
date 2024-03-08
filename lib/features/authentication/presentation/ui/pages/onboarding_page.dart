import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});
  static const routeName = RouteName.onboardingPage;

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  Future<void> navigationTo() async {
    return Future.delayed(
      const Duration(seconds: 2),
      () => Navigator.of(context).pushNamedAndRemoveUntil(
        RegisterPage.routeName,
        (route) => false,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    navigationTo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            LottieName.onboarding,
            width: 200,
            height: 200,
          ),
          const SizedBox(
            height: 50,
          ),
          Align(
            child: SizedBox(
              width: 250,
              child: Text(
                context.l10n.msg_onboarding,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
