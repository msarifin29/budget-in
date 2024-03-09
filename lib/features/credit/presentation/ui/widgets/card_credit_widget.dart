import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class CardCreditWidget extends StatelessWidget {
  const CardCreditWidget({
    super.key,
    required this.total,
    required this.category,
    required this.type,
    required this.startDate,
    required this.endDate,
    required this.color,
    this.onTap,
    this.plusMin = '',
    this.colorPlusMinus = ColorApp.green,
  });
  final int total;
  final String category;
  final String type;
  final String startDate;
  final String endDate;
  final Color color;
  final VoidCallback? onTap;
  final String plusMin;
  final Color colorPlusMinus;
  @override
  Widget build(BuildContext context) {
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
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: plusMin,
                      style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600, color: colorPlusMinus),
                      children: [
                        TextSpan(
                          text: ' Rp. ',
                          style: context.textTheme.bodyMedium!
                              .copyWith(color: colorPlusMinus),
                        ),
                        TextSpan(
                          text: total.toString(),
                          style: context.textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: colorPlusMinus),
                        ),
                      ],
                    ),
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
                        color: Colors.white,
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
                    category,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorApp.green.withOpacity(0.5),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: startDate,
                      style: context.textTheme.bodySmall!
                          .copyWith(color: colorPlusMinus),
                      children: [
                        TextSpan(
                          text: ' - ',
                          style: context.textTheme.bodySmall!
                              .copyWith(color: colorPlusMinus),
                        ),
                        TextSpan(
                          text: endDate,
                          style: context.textTheme.bodySmall!
                              .copyWith(color: colorPlusMinus),
                        ),
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
