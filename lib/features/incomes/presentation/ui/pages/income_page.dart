import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

class IncomePage extends StatelessWidget {
  static const routeName = RouteName.incomePage;
  const IncomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
          title: context.l10n.income,
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
            plusMin: '+',
            total: '25000',
            category: context.l10n.salary,
            type: context.l10n.cash,
            date: TimeUtil().today(ddMMyyy, DateTime.now()),
            color: ColorApp.green,
            onTap: () {},
          ),
          const SizedBox(height: 15),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NewIncomePage.routeName);
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
