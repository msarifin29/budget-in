import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

import 'line_chart_widget.dart';

class Desciption extends StatelessWidget {
  const Desciption({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          DescMonthlyReportWidget(
            text: context.l10n.expense,
            color: ColorApp.red,
            style: TextStyle(
              color: (Theme.of(context).brightness == Brightness.light
                  ? ColorApp.darkPrimary
                  : ColorApp.snowWhite),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20),
          DescMonthlyReportWidget(
            text: context.l10n.income,
            color: ColorApp.blue,
            style: TextStyle(
              color: (Theme.of(context).brightness == Brightness.light
                  ? ColorApp.darkPrimary
                  : ColorApp.snowWhite),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
