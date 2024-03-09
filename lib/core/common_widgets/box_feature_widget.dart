// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:budget_in/core/core.dart';

class BoxFeaturewidget extends StatelessWidget {
  const BoxFeaturewidget({
    super.key,
    required this.image,
    required this.title,
    required this.onPressed,
    this.color = Colors.white,
    this.colorText = Colors.green,
    required this.colorFilter,
  });
  final String image;
  final String title;
  final VoidCallback onPressed;
  final Color color;
  final Color colorFilter;
  final Color colorText;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(8.0),
      height: 65.0,
      color: color,
      splashColor: ColorApp.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(image,
              width: 25.0,
              colorFilter: ColorFilter.mode(colorFilter, BlendMode.srcIn)),
          const SizedBox(height: 5.0),
          Text(
            title,
            style: context.textTheme.bodySmall!.copyWith(
              color: colorText,
            ),
          ),
        ],
      ),
    );
  }
}
