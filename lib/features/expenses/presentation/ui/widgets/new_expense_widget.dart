// ignore_for_file: inference_failure_on_function_invocation

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/presentation/ui/widgets/submit_expenses_widget.dart';
import 'package:flutter/material.dart';

List<String> typeExpenses = [
  'cash',
  'debit',
  'credit',
];

class NewExpenseWidget extends StatefulWidget {
  const NewExpenseWidget({super.key});

  @override
  State<NewExpenseWidget> createState() => _NewExpenseWidgetState();
}

class _NewExpenseWidgetState extends State<NewExpenseWidget> {
  final types = ValueNotifier<String>('cash');
  final totalControl = TextEditingController();
  final notesControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text(
              Strings.newExpense,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.type,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Container(
                  height: 55,
                  width: double.infinity,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorApp.green),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  margin: const EdgeInsets.only(top: 5),
                  child: ValueListenableBuilder(
                    valueListenable: types,
                    builder: (context, value, _) {
                      return DropdownButton<String>(
                        elevation: 0,
                        value: types.value,
                        underline: const SizedBox(),
                        isExpanded: true,
                        focusColor: Colors.white,
                        items: [
                          ...typeExpenses.map((s) {
                            return DropdownMenuItem(
                              value: s,
                              child: Text(
                                s,
                                style: context.textTheme.bodyMedium,
                              ),
                            );
                          }),
                        ],
                        onChanged: (String? value) {
                          types.value = value!;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FormWidget(
              title: Strings.total,
              hint: '0',
              controller: totalControl,
              prefixIcon: const Padding(
                padding: EdgeInsets.all(8),
                child: Text('Rp.'),
              ),
              validator: (value) {
                if (value != null) {
                  return Strings.emptyTotal;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            FormWidget(
              title: Strings.notes,
              hint: '',
              controller: notesControl,
              maxLines: 2,
            ),
            const SizedBox(height: 50),
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
                    Strings.cancel,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    showDialog(
                      context: context,
                      builder: (context) => const SubmitExpensesWidget(),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorApp.green,
                    minimumSize: const Size(100, 50),
                  ),
                  child: Text(
                    Strings.save,
                    style: context.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
