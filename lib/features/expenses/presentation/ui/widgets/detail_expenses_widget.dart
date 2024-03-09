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
  final DateTime date;
  final int total;
  final String category;
  final String notes;

  @override
  Widget build(BuildContext context) {
    final time = TimeUtil().today(dmy, date);
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
          InfoWidget(k: context.l10n.date, v: ': $time'),
          InfoWidget(k: context.l10n.total, v: ': Rp. $total'),
          InfoWidget(k: context.l10n.category, v: ': $category'),
          InfoWidget(k: context.l10n.notes, v: ': $notes'),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    required this.k,
    required this.v,
    super.key,
  });

  final String k;
  final String v;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              k,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            v,
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
