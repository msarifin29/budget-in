import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class AmountCardWidget extends StatelessWidget {
  const AmountCardWidget({
    super.key,
    required this.total,
    required this.category,
    required this.type,
    required this.date,
    required this.color,
  });
  final int total;
  final String category;
  final String type;
  final String date;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 80,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
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
                    text: 'Rp. ',
                    style: context.textTheme.bodyMedium!,
                    children: [
                      TextSpan(
                        text: total.toString(),
                        style: context.textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.w600, color: ColorApp.green),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: category,
                    style: context.textTheme.bodyMedium!,
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
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
