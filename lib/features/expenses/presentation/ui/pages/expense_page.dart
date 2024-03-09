// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_in/core/helpers/util_date.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';

class ExpensePage extends StatelessWidget {
  static const routeName = RouteName.expensePage;
  const ExpensePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
          title: context.l10n.expense,
          actions: [
            SvgButton(
                image: SvgName.filterWhite,
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) => FilterWidget(
                      onPressedCash: () {},
                      onPressedNonCash: () {},
                    ),
                  );
                }),
            const SizedBox(width: 15.0),
          ],
        ),
      ),
      body: Column(
        children: [
          AmountCardWidget(
            total: 25000,
            category: 'Food and Drink',
            type: context.l10n.cash,
            date: UtilDate.today('dd/MM/yyyy HH:mm', DateTime.now()),
            color: ColorApp.green,
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  builder: (context) {
                    return DetailExpensesWidget(
                      type: context.l10n.cash,
                      date: DateTime.now(),
                      total: 25000,
                      category: context.l10n.food_and_beverage,
                      notes: '',
                    );
                  });
            },
          ),
          const SizedBox(height: 15),
          AmountCardWidget(
            total: 500000,
            category: 'Food and Drink',
            type: context.l10n.non_cash,
            date: UtilDate.today('dd/MM/yyyy HH:mm', DateTime.now()),
            color: ColorApp.blue,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              builder: (context) {
                return const NewExpenseWidget();
              });
        },
        tooltip: context.l10n.new_expense,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add_circle_outline,
          color: ColorApp.green,
          size: 40,
        ),
      ),
    );
  }
}

class NewExpenseWidget extends StatefulWidget {
  const NewExpenseWidget({super.key});

  @override
  State<NewExpenseWidget> createState() => _NewExpenseWidgetState();
}

class _NewExpenseWidgetState extends State<NewExpenseWidget> {
  final globalKey = GlobalKey<FormState>();
  final idSelected = ValueNotifier(13);
  final idType = ValueNotifier(2);

  final typeExpenseC = TextEditingController();
  final notesC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final categoryExpepenses = [
      ItemChoice(1, context.l10n.food_and_beverage),
      ItemChoice(2, context.l10n.shopping),
      ItemChoice(3, context.l10n.transport),
      ItemChoice(4, context.l10n.motorcycle_or_car),
      ItemChoice(5, context.l10n.traveling),
      ItemChoice(6, context.l10n.healty),
      ItemChoice(7, context.l10n.cost_and_bill),
      ItemChoice(8, context.l10n.education),
      ItemChoice(9, context.l10n.sport_and_hoby),
      ItemChoice(10, context.l10n.beauty),
      ItemChoice(11, context.l10n.work),
      ItemChoice(12, context.l10n.food_ingredients),
      ItemChoice(13, context.l10n.other),
    ];
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
          child: Form(
            key: globalKey,
            child: Column(
              children: [
                Text(
                  context.l10n.new_expense,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorApp.green,
                  ),
                ),
                const SizedBox(height: 20),
                FormWidget(
                  title: context.l10n.total,
                  hint: '',
                  controller: typeExpenseC,
                ),
                FormWidget(
                  title: 'Notes',
                  hint: '',
                  controller: notesC,
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.type_x(context.l10n.expense),
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ValueListenableBuilder(
                        valueListenable: idType,
                        builder: (context, v, _) {
                          return Row(
                            children: [
                              ItemChoice(1, context.l10n.cash),
                              ItemChoice(2, context.l10n.non_cash),
                            ]
                                .map((e) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: ChoiceChip(
                                        label: Text(e.label),
                                        selected: idType.value == e.id,
                                        onSelected: (_) => idType.value = e.id,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        }),
                  ],
                ),
                const SizedBox(height: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.category,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ValueListenableBuilder(
                      valueListenable: idSelected,
                      builder: (context, v, _) {
                        return Wrap(
                          spacing: 8,
                          children: categoryExpepenses
                              .map(
                                (e) => ChoiceChip(
                                  label: Text(e.label),
                                  selected: idSelected.value == e.id,
                                  onSelected: (_) => idSelected.value = e.id,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                PrimaryButton(
                  text: context.l10n.submit,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyExpenseWidget extends StatelessWidget {
  const EmptyExpenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageEmptyWidget(),
          Text(
            context.l10n.empty_expense_msg,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium!.copyWith(
              color: ColorApp.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
