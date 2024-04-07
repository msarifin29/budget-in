import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CardCreditWidget extends StatelessWidget {
  const CardCreditWidget({
    super.key,
    required this.creditData,
    required this.color,
    this.onTap,
  });
  final CreditData creditData;
  final Color color;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    TextStyle? bodySmallStyle = context.textTheme.bodySmall!.copyWith(
      color: creditData.statusCredit == 'active' ? color : ColorApp.green,
    );
    final categoryData = creditData.categoryData ??
        CategoryData(
          categoryId: creditData.id,
          id: 1,
          title: context.l10n.other,
        );
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 80,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).cardColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: ' Rp. ',
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: creditData.statusCredit == 'active'
                              ? color
                              : ColorApp.green),
                      children: [
                        TextSpan(
                          text:
                              '${creditData.total <= 0 ? 0 : creditData.total}',
                          style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: creditData.statusCredit == 'active'
                                ? color
                                : ColorApp.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 90,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: creditData.statusCredit == 'active'
                          ? color
                          : ColorApp.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      creditData.statusCredit,
                      style: context.textTheme.labelSmall!.copyWith(
                        color: (Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : ColorApp.darkPrimary),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    categoryData.title,
                    style: context.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: creditData.statusCredit == 'active'
                          ? color.withOpacity(0.5)
                          : ColorApp.green,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: TimeUtil().today(
                          monthYear,
                          DateTime.parse(
                              creditData.startDate ?? '2000-01-02T00:00:00Z')),
                      style: bodySmallStyle,
                      children: [
                        TextSpan(text: ' - ', style: bodySmallStyle),
                        TextSpan(
                            text: TimeUtil().today(
                                monthYear,
                                DateTime.parse(creditData.endDate ??
                                    '2000-01-02T00:00:00Z')),
                            style: bodySmallStyle),
                      ],
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
