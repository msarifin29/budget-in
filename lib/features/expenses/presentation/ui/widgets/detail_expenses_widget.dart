// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DetailExpensesWidget extends StatelessWidget {
  const DetailExpensesWidget({
    required this.type,
    required this.date,
    required this.total,
    required this.notes,
    super.key,
  });

  final String type;
  final DateTime date;
  final double total;
  final String notes;

  @override
  Widget build(BuildContext context) {
    final time = TimeUtil().today(dmy, date);
    return Dialog(
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(
              LottieName.wallet,
              width: 150,
            ),
            const SizedBox(
              height: 24,
            ),
            InfoWidget(k: Strings.type, v: ': $type'),
            InfoWidget(k: Strings.date, v: ': $time'),
            InfoWidget(k: Strings.total, v: ': Rp. $total'),
            InfoWidget(k: Strings.notes, v: ': $notes'),
          ],
        ),
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
            width: 65,
            child: Text(
              k,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            v,
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
