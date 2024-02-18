import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class ItemProfileWidget extends StatelessWidget {
  const ItemProfileWidget({
    required this.k,
    required this.v,
    super.key,
  });

  final String k;
  final String v;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$k :',
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(
                v,
                style: context.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
