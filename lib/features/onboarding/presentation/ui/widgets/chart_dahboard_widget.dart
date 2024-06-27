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
    bool expenseIsEmpty(List<CategoryValue> expenses) {
      double newTotal = 0.0;
      for (final t in expenses) {
        newTotal += t.total;
      }
      if (newTotal <= 0) {
        return true;
      }
      return false;
    }

    final size = MediaQuery.sizeOf(context);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      elevation: 10,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : ColorApp.night),
          borderRadius: BorderRadius.circular(12),
        ),
        child: BlocBuilder<MonthlyReportDashboardBloc,
            MonthlyReportDashboardState>(
          builder: (context, state) {
            if (state is MonthlyReportDashboardLoading) {
              return SizedBox(
                height: size.height * 0.3,
                child: const CircularLoading(),
              );
            } else if (state is MonthlyReportDashboardFailure) {
              return RefreshButton(onPressed: () {
                callBack();
              });
            } else if (state is MonthlyReportDashboardSuccess) {
              final expenses = state.data.expenses;
              if (expenseIsEmpty(expenses)) {
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: EmptyWidget(text: context.l10n.empty_expense_msg),
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ChartExpenseWidget(expenses: expenses),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.3,
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
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
