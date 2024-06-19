// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_in/features/onboarding/data/models/monthly_report_detail_response.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/expenses.dart';

class CardExpenseWidget extends StatelessWidget {
  const CardExpenseWidget({
    super.key,
    this.onTap,
    required this.data,
    this.x = '-',
  });

  final VoidCallback? onTap;
  final ExpenseData data;
  final String x;

  @override
  Widget build(BuildContext context) {
    final date = TimeUtil().today(
        ddMMyyy, DateTime.parse(data.createdAt ?? '2012-12-12T15:54:11Z'));
    final category = data.tCategory ?? const TCategory();
    Color titleColor = Theme.of(context).brightness == Brightness.dark
        ? ColorApp.grey
        : ColorApp.darkPrimary;
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    category.title ?? '',
                    style: context.textTheme.titleSmall!.copyWith(
                      color: titleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: x,
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600, color: ColorApp.red),
                      children: [
                        TextSpan(
                          text: ' Rp',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: ColorApp.red.withOpacity(0.7),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(
                          text: Helpers.currency(data.total),
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: ColorApp.red.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              (data.bankName ?? '').isEmpty
                  ? const SizedBox.shrink()
                  : Text(
                      data.bankName ?? '',
                      style: context.textTheme.bodySmall!.copyWith(
                        color: titleColor,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    date,
                    style: context.textTheme.bodySmall!.copyWith(
                      color: titleColor,
                    ),
                  ),
                  data.expenseType == ConstantType.debit
                      ? const SizedBox.shrink()
                      : Text(
                          data.expenseType == ConstantType.cash
                              ? context.l10n.cash
                              : context.l10n.non_cash,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: titleColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
