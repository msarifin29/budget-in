import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Align(
          child: Lottie.asset(
            LottieName.wallet,
            width: 150,
            height: 150,
          ),
        ),
        Align(
          child: Text(
            Strings.budgetIn,
            style: context.textTheme.titleLarge?.copyWith(
              color: ColorApp.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
