// ignore_for_file: public_member_api_docs, sort_constructors_first, inference_failure_on_function_invocation, lines_longer_than_80_chars
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:flutter/material.dart';

class CardExpensesWidget extends StatelessWidget {
  const CardExpensesWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final date = DateTime.now();
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 35),
      decoration: BoxDecoration(
        border: Border.all(color: ColorApp.green),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        hoverColor: Colors.white,
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => DetailExpensesWidget(
              type: 'cash',
              date: DateTime.now(),
              total: 500000,
              category: '',
              notes: '',
            ),
          );
        },
        onLongPress: () {},
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  TimeUtil().today(monthDay, date),
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 24),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorApp.blue,
                  ),
                  child: Text(
                    'cash',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Rp. ',
                    style: context.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text: '2.000.000',
                    style: context.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
