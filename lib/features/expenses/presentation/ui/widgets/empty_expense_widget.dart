import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyExpenseWidget extends StatelessWidget {
  const EmptyExpenseWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 150),
      child: Column(
        children: [
          Lottie.asset(
            LottieName.empty,
            width: 150,
            height: 150,
          ),
          const Text(Strings.emptyExpense),
        ],
      ),
    );
  }
}
