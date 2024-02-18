import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class SubmitExpensesWidget extends StatelessWidget {
  const SubmitExpensesWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              Strings.confirmExpenses,
              textAlign: TextAlign.center,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.red,
                    minimumSize: const Size(100, 50),
                  ),
                  child: Text(
                    Strings.no,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.green,
                    minimumSize: const Size(100, 50),
                  ),
                  child: Text(
                    Strings.yes,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
