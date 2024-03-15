// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DetailExpensesWidget extends StatelessWidget {
  const DetailExpensesWidget({
    required this.type,
    required this.date,
    required this.total,
    required this.category,
    required this.notes,
    super.key,
  });

  final String type;
  final String date;
  final String total;
  final String category;
  final String notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            LottieName.wallet,
            width: 120,
          ),
          const SizedBox(height: 10),
          InfoWidget(
              k: context.l10n.type_x(context.l10n.expense), v: ': $type'),
          InfoWidget(k: context.l10n.date, v: ': $date'),
          InfoWidget(k: context.l10n.total, v: ': Rp. $total'),
          InfoWidget(k: context.l10n.category, v: ': $category'),
          InfoWidget(k: context.l10n.notes, v: ': $notes'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
