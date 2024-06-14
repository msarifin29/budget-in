import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String stringMonth(BuildContext context, int month) {
  switch (month) {
    case 1:
      return context.l10n.jan;
    case 2:
      return context.l10n.feb;
    case 3:
      return context.l10n.mar;
    case 4:
      return context.l10n.apr;
    case 5:
      return context.l10n.may;
    case 6:
      return context.l10n.jun;
    case 7:
      return context.l10n.jul;
    case 8:
      return context.l10n.aug;
    case 9:
      return context.l10n.sep;
    case 10:
      return context.l10n.oct;
    case 11:
      return context.l10n.nov;
    case 12:
      return context.l10n.dec;
    default:
      return '';
  }
}

class MonthlyReportPage extends StatelessWidget {
  static const routeName = RouteName.monthlyReportPage;
  const MonthlyReportPage({super.key, required this.data});
  final List<MonthlyReportData> data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
            title: TimeUtil().today(yyyy, DateTime.now()), leading: true),
      ),
      body: data[0].month == 0
          ? EmptyWidget(text: context.l10n.empty_monthly_report)
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, i) {
                final item = data[i];
                String te = NumberFormat.currency(
                        locale: 'ID', symbol: '', decimalDigits: 0)
                    .format(item.totalExpense);
                String ti = NumberFormat.currency(
                        locale: 'ID', symbol: '', decimalDigits: 0)
                    .format(item.totalIncome);
                return item.totalExpense != 0 || item.totalIncome != 0
                    ? InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            MonthlyReportDetailPage.routeName,
                            arguments: {
                              NamedArguments.year: item.year,
                              NamedArguments.month: item.month,
                            },
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  child: Text(
                                    stringMonth(context, item.month),
                                    style: context.textTheme.bodySmall!,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextItem(
                                        title: context.l10n.expense,
                                        total: te,
                                      ),
                                      TextItem(
                                        title: context.l10n.income,
                                        total: ti,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
