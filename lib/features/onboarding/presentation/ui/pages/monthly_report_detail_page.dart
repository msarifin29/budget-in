import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

class MonthlyReportDetailPage extends StatelessWidget {
  static const routeName = RouteName.monthlyReportDetailPage;
  const MonthlyReportDetailPage({super.key, required this.data});
  final List<MonthlyReportData> data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
            title: TimeUtil().today(monthYear, DateTime.now()), leading: true),
      ),
      body: data[0].month == 0
          ? EmptyWidget(text: context.l10n.empty_monthly_report)
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                final item = data[i];

                return item.totalExpense != 0 || item.totalIncome != 0
                    ? Card(
                        margin: const EdgeInsets.all(5),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                child: Text('${item.month}'),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextItem(
                                      title: context.l10n.expense,
                                      total: '${item.totalExpense}',
                                    ),
                                    TextItem(
                                      title: context.l10n.income,
                                      total: '${item.totalIncome}',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox();
              },
            ),
    );
  }
}

class TextItem extends StatelessWidget {
  const TextItem({
    super.key,
    required this.title,
    required this.total,
  });

  final String title;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            title,
            style: context.textTheme.labelSmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: (Theme.of(context).primaryColor == ColorApp.green
                  ? Colors.black
                  : Colors.grey),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Text(
          'Rp. $total',
          style: context.textTheme.labelSmall!.copyWith(
            fontWeight: FontWeight.w400,
            color: (Theme.of(context).primaryColor == ColorApp.green
                ? Colors.black
                : Colors.grey),
          ),
        ),
      ],
    );
  }
}
