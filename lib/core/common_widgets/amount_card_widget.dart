// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';

class AmountCardWidget extends StatelessWidget {
  const AmountCardWidget({
    super.key,
    required this.total,
    required this.category,
    required this.type,
    required this.date,
    required this.color,
    this.onTap,
    this.plusMin = '',
    this.colorPlusMinus,
    this.colorNumber,
  });
  final String total;
  final String category;
  final String type;
  final String date;
  final Color color;
  final VoidCallback? onTap;
  final String plusMin;
  final Color? colorPlusMinus;
  final Color? colorNumber;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          height: 65,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  RichText(
                    text: TextSpan(
                      text: plusMin,
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorNumber ??
                              (Theme.of(context).brightness == Brightness.light
                                  ? ColorApp.green
                                  : Colors.grey)),
                      children: [
                        TextSpan(
                          text: ' Rp. ',
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: colorNumber ??
                                  (Theme.of(context).brightness ==
                                          Brightness.light
                                      ? ColorApp.green
                                      : Colors.grey)),
                        ),
                        TextSpan(
                          text: total,
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorNumber ??
                                  (Theme.of(context).brightness ==
                                          Brightness.light
                                      ? ColorApp.green
                                      : Colors.grey)),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: category,
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: colorPlusMinus ??
                            (Theme.of(context).brightness == Brightness.light
                                ? ColorApp.green
                                : Colors.grey),
                      ),
                      children: [
                        TextSpan(
                          text: '  $date',
                          style: context.textTheme.bodySmall!.copyWith(
                            color: ColorApp.green.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 25,
                width: 90,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  type,
                  style: context.textTheme.labelSmall!.copyWith(
                    color: (Theme.of(context).brightness == Brightness.light
                        ? Colors.white
                        : Colors.grey),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
