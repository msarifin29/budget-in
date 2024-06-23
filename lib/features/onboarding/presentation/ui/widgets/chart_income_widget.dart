import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ChartIncomeWidget extends StatelessWidget {
  final List<CategoryValue> incomes;
  const ChartIncomeWidget({super.key, required this.incomes});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    double total() {
      double newTotal = 0.0;
      for (final t in incomes) {
        newTotal += t.total;
      }
      return newTotal;
    }

    Color lighten(Color color, [double amount = 0.1]) {
      assert(amount >= -1 && amount <= 1);

      final hsl = HSLColor.fromColor(color);
      final hslLight =
          hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

      return hslLight.toColor();
    }

    Color colorFn(int i) {
      final l = List.generate(incomes.length, (i) {
        Color c = lighten(ColorApp.green, -0.2);
        for (int j = 0; j < i; j++) {
          c = lighten(c);
        }
        return c;
      });
      return l[i];
    }

    List<PieChartSectionData> showingSections() {
      return List.generate(
        incomes.length,
        (i) {
          return PieChartSectionData(
            color: colorFn(i),
            value: incomes[i].total < 0 ? 0 : incomes[i].total,
            radius: 100,
            showTitle: false,
            badgeWidget: Card(
              child: AnimatedSize(
                duration: const Duration(milliseconds: 200),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                  child: Text(
                    NumberFormat.currency(
                      locale: 'ID',
                      symbol: '',
                      decimalDigits: 0,
                    ).format(
                      incomes[i].total,
                    ),
                    style: GoogleFonts.publicSans(
                      textStyle: context.textTheme.labelSmall!,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            badgePositionPercentageOffset: .85,
          );
        },
      );
    }

    return Column(
      children: [
        SizedBox(
          height: size.height * 0.3,
          width: double.infinity,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {},
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 0,
              centerSpaceRadius: 0,
              sections: showingSections(),
            ),
          ),
        ),
        Container(
          height: size.height * 0.5,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            ...incomes.map((i) {
              String total = NumberFormat.currency(
                locale: 'ID',
                symbol: '',
                decimalDigits: 0,
              ).format(i.total);
              return TextItem(
                title: i.title,
                total: total,
              );
            }),
            const Divider(),
            TextItem(
              title: context.l10n.total,
              total: NumberFormat.currency(
                locale: 'ID',
                symbol: '',
                decimalDigits: 0,
              ).format(
                total(),
              ),
            )
          ]),
        ),
      ],
    );
  }
}
