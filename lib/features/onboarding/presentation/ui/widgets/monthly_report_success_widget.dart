import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MonthlyReportSuccessWidget extends StatelessWidget {
  const MonthlyReportSuccessWidget({super.key, required this.data});

  final List<MonthlyReportData> data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return data[0].month == 0
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
                    String te = Helpers.currency(item.totalExpense);
                    String ti = Helpers.currency(item.totalIncome);
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
                              elevation: 8,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: (Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.white
                                      : ColorApp.night),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  touchCallback: (e, ptr) {},
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
                                                MainAxisAlignment.spaceBetween,
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
                                                  item.totalExpense,
                                                ),
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
          );
  }
}
