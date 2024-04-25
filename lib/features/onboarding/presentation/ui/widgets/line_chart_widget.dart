// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:budget_in/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});
  @override
  State<StatefulWidget> createState() => LineChartWidgetState();
}

class LineChartWidgetState extends State<LineChartWidget> {
  List<BarChartGroupData> rawBarGroups = [];
  List<BarChartGroupData> showingBarGroups = [];
  double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }

  void getMonthlyEvent() {
    context.read<GetMonthlyReportBloc>().add(
          MonthlyReportInitialEvent(uid: Helpers.getUid()),
        );
  }

  @override
  void initState() {
    getMonthlyEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      color: (Theme.of(context).brightness == Brightness.light
          ? ColorApp.grey20
          : ColorApp.night),
      child: BlocBuilder<GetMonthlyReportBloc, GetMonthlyReportState>(
          builder: (context, state) {
        log('GetMonthlyReport $state');
        if (state is GetMonthlyReportLoading) {
          return const CircularLoading();
        } else if (state is GetMonthlyReportFailure) {
          return RefreshButton(onPressed: () {
            getMonthlyEvent();
          });
        } else if (state is GetMonthlyReportSuccess) {
          final report = state.data;
          rawBarGroups = List.generate(
            report.length,
            (i) {
              double patern = double.parse('1000000');
              double y1 = report[i].totalExpense.toDouble() / patern;
              double y2 = report[i].totalIncome.toDouble() / patern;
              return makeGroupData(i, y1, y2);
            },
          );
          showingBarGroups = rawBarGroups;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        DescMonthlyReportWidget(
                            text: context.l10n.expense, color: ColorApp.red),
                        DescMonthlyReportWidget(
                            text: context.l10n.income, color: ColorApp.blue),
                      ],
                    ),
                    Text(
                      context.l10n.monthly_report,
                      style: context.textTheme.bodySmall!.copyWith(
                        color: ColorApp.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          MonthlyReportDetailPage.routeName,
                          arguments: {
                            NamedArguments.data: report,
                          },
                        );
                      },
                      icon: const Icon(Icons.more_horiz_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: BarChart(
                    BarChartData(
                      maxY: 5,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.grey,
                          getTooltipItem: (a, b, c, d) => null,
                        ),
                      ),
                      titlesData: FlTitlesData(
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: bottomTitles,
                            reservedSize: 25,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            interval: 1,
                            getTitlesWidget: leftTitles,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: showingBarGroups,
                      gridData: const FlGridData(show: false),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          );
        }
        return const SizedBox();
      }),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: ColorApp.green,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 1) {
      text = '1${context.l10n.milion}';
    } else if (value == 2) {
      text = '2${context.l10n.milion}';
    } else if (value == 3) {
      text = '3${context.l10n.milion}';
    } else if (value == 4) {
      text = '4${context.l10n.milion}';
    } else if (value == 5) {
      text = '5${context.l10n.milion}';
    } else {
      return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      context.l10n.jan,
      context.l10n.feb,
      context.l10n.mar,
      context.l10n.apr,
      context.l10n.may,
      context.l10n.jan,
      context.l10n.jul,
      context.l10n.aug,
      context.l10n.sep,
      context.l10n.oct,
      context.l10n.nov,
      context.l10n.dec
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 10,
        color: Colors.grey,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      angle: degreeToRadian(value < 0 ? 50 : -50),
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1 > 5 ? 5.0 : y1,
          color: ColorApp.red,
          width: 3,
        ),
        BarChartRodData(
          toY: y2 > 5 ? 5.0 : y2,
          color: ColorApp.blue,
          width: 3,
        ),
      ],
    );
  }
}

class DescMonthlyReportWidget extends StatelessWidget {
  const DescMonthlyReportWidget({
    super.key,
    required this.text,
    required this.color,
  });
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(height: 4, width: 25, color: color),
        const SizedBox(width: 10),
        Text(
          text,
          style: context.textTheme.bodySmall!.copyWith(
            color: color,
            fontWeight: FontWeight.w400,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
