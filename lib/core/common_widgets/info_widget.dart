import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    required this.k,
    required this.v,
    this.width = 120,
    super.key,
  });

  final String k;
  final String v;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          SizedBox(
            width: width,
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

class InfoSmallWidget extends StatelessWidget {
  const InfoSmallWidget({
    required this.k,
    required this.v,
    this.width = 100,
    super.key,
  });

  final String k;
  final String v;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Row(
        children: [
          SizedBox(
            width: width,
            child: Text(
              k,
              style: context.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
          ),
          Text(
            v,
            style: context.textTheme.bodySmall
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
