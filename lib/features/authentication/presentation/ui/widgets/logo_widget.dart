// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top: 20, bottom: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: ColorApp.grey,
      ),
      child: Column(
        children: [
          const Align(child: ImageLogo(size: 60)),
          Align(
            child: Text(
              Strings.budgetIn,
              style: context.textTheme.bodyMedium?.copyWith(
                color: ColorApp.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ImageLogo extends StatelessWidget {
  const ImageLogo({
    super.key,
    this.size = 100,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(ImageName.logo, width: size, height: size);
  }
}
