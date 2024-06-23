import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

String stringTotal(int income, int expense) {
  int total = income - expense;
  if (total == 0) {
    return '';
  }
  String newTotal =
      NumberFormat.currency(locale: 'ID', symbol: '', decimalDigits: 0)
          .format(total);
  return newTotal;
}

class MonthlyReportPage extends StatelessWidget {
  static const routeName = RouteName.monthlyReportPage;
  const MonthlyReportPage({super.key, required this.data});
  final List<MonthlyReportData> data;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
            title: TimeUtil().today(yyyy, DateTime.now()), leading: true),
      ),
      body: data[0].month == 0
          ? EmptyWidget(text: context.l10n.empty_monthly_report)
          : Column(
              children: [
                const Desciption(),
                SizedBox(
                  height: size.height * 0.8,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      final item = data[i];
                      String te = NumberFormat.currency(
                              locale: 'ID', symbol: '', decimalDigits: 0)
                          .format(item.totalExpense);
                      String ti = NumberFormat.currency(
                              locale: 'ID', symbol: '', decimalDigits: 0)
                          .format(item.totalIncome);
                      stringTotal(item.totalIncome, item.totalExpense);
                      final month = TimeUtil().today(yyyy, DateTime.now());
                      List<PieChartSectionData> showingSections() {
                        int total = item.totalIncome + item.totalExpense;
                        double percentageIncome =
                            (item.totalIncome / total) * 100;
                        double percentageExpense =
                            (item.totalExpense / total) * 100;
                        return List.generate(
                          2,
                          (i) {
                            const color0 = ColorApp.blue;
                            const color1 = ColorApp.red;
                            switch (i) {
                              case 0:
                                return PieChartSectionData(
                                    color: color0,
                                    value: percentageIncome,
                                    radius: 35,
                                    title: '${percentageIncome.toInt()}%',
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ));
                              case 1:
                                return PieChartSectionData(
                                    color: color1,
                                    value: percentageExpense,
                                    radius: 35,
                                    title: '${percentageExpense.toInt()}%',
                                    titleStyle: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ));

                              default:
                                throw Error();
                            }
                          },
                        );
                      }

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
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${stringMonth(context, item.month)} $month',
                                        style: GoogleFonts.publicSans(
                                            textStyle:
                                                context.textTheme.bodyMedium!,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: SizedBox(
                                              height: 45,
                                              width: 45,
                                              child: PieChart(
                                                PieChartData(
                                                  pieTouchData: PieTouchData(
                                                    touchCallback: (FlTouchEvent
                                                            event,
                                                        pieTouchResponse) {},
                                                  ),
                                                  borderData:
                                                      FlBorderData(show: false),
                                                  sectionsSpace: 0,
                                                  centerSpaceRadius: 0,
                                                  sections: showingSections(),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.65,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextItem(
                                                  title: context.l10n.income,
                                                  total: ti,
                                                ),
                                                TextItem(
                                                  title: context.l10n.expense,
                                                  total: te,
                                                ),
                                                const Divider(),
                                                TextItem(
                                                  title: context.l10n.total,
                                                  total: stringTotal(
                                                      item.totalIncome,
                                                      item.totalExpense),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10)
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class Desciption extends StatelessWidget {
  const Desciption({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          DescMonthlyReportWidget(
            text: context.l10n.expense,
            color: ColorApp.red,
            style: TextStyle(
              color: (Theme.of(context).brightness == Brightness.light
                  ? ColorApp.darkPrimary
                  : ColorApp.snowWhite),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 20),
          DescMonthlyReportWidget(
            text: context.l10n.income,
            color: ColorApp.blue,
            style: TextStyle(
              color: (Theme.of(context).brightness == Brightness.light
                  ? ColorApp.darkPrimary
                  : ColorApp.snowWhite),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: GoogleFonts.publicSans(
              textStyle: context.textTheme.bodyMedium!,
              fontWeight: FontWeight.w500),
        ),
        Text(
          'Rp. $total',
          style: GoogleFonts.publicSans(
              textStyle: context.textTheme.bodyMedium!,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
