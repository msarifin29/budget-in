// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const Align(child: ImageLogo(size: 100)),
        Align(
          child: Text(
            Strings.budgetIn,
            style: context.textTheme.titleLarge?.copyWith(
              color: ColorApp.green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
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
    return Image.asset(ImageName.budgetInImage, width: size, height: size);
  }
}
