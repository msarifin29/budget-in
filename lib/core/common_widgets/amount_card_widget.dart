// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';
import 'package:google_fonts/google_fonts.dart';

class AmountCardWidget extends StatelessWidget {
  const AmountCardWidget({
    super.key,
    required this.data,
    this.onTap,
  });
  final VoidCallback? onTap;
  final IncomeData data;
  @override
  Widget build(BuildContext context) {
    final date = TimeUtil().today(ddMMyyy, DateTime.parse(data.createdAt));
    final category = data.categoryData ?? const CategoryData();
    Color titleColor = Theme.of(context).brightness == Brightness.dark
        ? ColorApp.grey
        : Colors.black87;
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  Text(
                    '+Rp${Helpers.currency(data.total)}',
                    style: GoogleFonts.archivoBlack(
                      textStyle: context.textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: (Theme.of(context).brightness == Brightness.light
                            ? ColorApp.night
                            : ColorApp.snowWhite),
                      ),
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
                  data.typeIncome == ConstantType.debit
                      ? const SizedBox.shrink()
                      : Text(
                          data.typeIncome == ConstantType.cash
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

class ContainerFilterWidget extends StatelessWidget {
  const ContainerFilterWidget({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: child,
      ),
    );
  }
}
