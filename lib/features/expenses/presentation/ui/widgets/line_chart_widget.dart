// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_in/l10n/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:budget_in/core/core.dart';

class Report {
  final double expense;
  final double income;
  Report(this.expense, this.income);
}

class LineChartWidget extends StatefulWidget {
  const LineChartWidget({super.key});
  @override
  State<StatefulWidget> createState() => LineChartWidgetState();
}

class LineChartWidgetState extends State<LineChartWidget> {
  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;
  final reports = [
    Report(4, 3),
    Report(2, 4),
    Report(4, 6),
    Report(2, 7),
    Report(9, 1),
    Report(3, 6),
    Report(4, 3),
    Report(9, 1),
    Report(3, 6),
    Report(4, 3),
    Report(12, 4),
    Report(14, 6),
  ];
  @override
  void initState() {
    super.initState();
    rawBarGroups = List.generate(reports.length,
        (i) => makeGroupData(i, reports[i].expense, reports[i].income));

    showingBarGroups = rawBarGroups;
  }

  double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: (Theme.of(context).brightness == Brightness.light
          ? ColorApp.grey20
          : ColorApp.rootBeer),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 5),
            Text(
              context.l10n.monthly_report,
              style: context.textTheme.bodySmall!.copyWith(
                color: ColorApp.green,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: BarChart(
                BarChartData(
                  maxY: 10,
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
                        reservedSize: 35,
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
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: ColorApp.blue,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    if (value == 0) {
      text = '0';
    } else if (value == 2) {
      text = '2B';
    } else if (value == 4) {
      text = '4B';
    } else if (value == 6) {
      text = '6B';
    } else if (value == 8) {
      text = '8B';
    } else if (value == 10) {
      text = '10B';
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
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
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
          toY: y1 > 10 ? 10.0 : y1,
          color: ColorApp.red,
          width: 3,
        ),
        BarChartRodData(
          toY: y2 > 10 ? 10.0 : y2,
          color: ColorApp.blue,
          width: 3,
        ),
      ],
    );
  }
}
