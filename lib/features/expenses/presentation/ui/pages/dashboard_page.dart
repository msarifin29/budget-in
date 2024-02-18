// ignore_for_file: inference_failure_on_function_invocation, require_trailing_commas, lines_longer_than_80_chars

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  static const routeName = RouteName.dashboardPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, 100),
        child: LeadingDashboardWidget(),
      ),
      body: const ExpenseContentWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorApp.grey20,
        onPressed: () {
          showDialog(
              context: context, builder: (context) => const NewExpenseWidget());
        },
        child: SvgPicture.asset(SvgName.newExpense),
      ),
    );
  }
}

class ExpenseContentWidget extends StatelessWidget {
  const ExpenseContentWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        const SearchExpensesWidget(),
        const SizedBox(height: 10),
        Align(
          child: Text(
            TimeUtil().today(monthYear, DateTime.now()),
            style: context.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 10),
        const CardExpensesWidget(),
        const SizedBox(height: 10),
        const CardExpensesWidget(),
        const SizedBox(height: 10),
        const CardExpensesWidget(),
      ],
    );
  }
}

class SearchExpensesWidget extends StatefulWidget {
  const SearchExpensesWidget({
    super.key,
  });

  @override
  State<SearchExpensesWidget> createState() => _SearchExpensesWidgetState();
}

class _SearchExpensesWidgetState extends State<SearchExpensesWidget> {
  final inputControl = TextEditingController();

  @override
  void dispose() {
    inputControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: context.mediaQuery.size.width - 50.0,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            style: context.textTheme.bodySmall,
            controller: inputControl,
            decoration: inputDecoratonTextField(
              context: context,
            ),
          ),
        ),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          hoverColor: ColorApp.grey,
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SvgPicture.asset(
              SvgName.calendar,
              width: 30,
            ),
          ),
        ),
      ],
    );
  }
}
