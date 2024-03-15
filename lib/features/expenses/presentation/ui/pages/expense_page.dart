// ignore_for_file: public_member_api_docs, sort_constructors_first

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
            date: TimeUtil().today('dd/MM/yyyy HH:mm', DateTime.now()),
            color: ColorApp.green,
            onTap: () {
              showModalBottomSheet(
                  context: context,
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
            date: TimeUtil().today('dd/MM/yyyy HH:mm', DateTime.now()),
            color: ColorApp.blue,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RouteName.newExpensePage);
        },
        tooltip: context.l10n.new_expense,
        backgroundColor: Theme.of(context).cardColor,
        child: const Icon(
          Icons.add_circle_outline,
          color: ColorApp.green,
          size: 40,
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
