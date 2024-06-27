import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChartDashboardWidget extends StatelessWidget {
  const ChartDashboardWidget({super.key, required this.callBack});
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            child: BlocBuilder<MonthlyReportDashboardBloc,
                MonthlyReportDashboardState>(
              builder: (context, state) {
                if (state is MonthlyReportDashboardLoading) {
                  return const CircularLoading();
                } else if (state is MonthlyReportDashboardFailure) {
                  return RefreshButton(onPressed: () {
                    callBack();
                  });
                } else if (state is MonthlyReportDashboardSuccess) {
                  final expenses = state.data.expenses;
                  return ChartExpenseWidget(expenses: expenses);
                }
                return const SizedBox();
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.2,
              vertical: 24,
            ),
            child: PrimaryOutlineButton(
              text: context.l10n.more,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  MonthlyReportPage.routeName,
                  arguments: {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
