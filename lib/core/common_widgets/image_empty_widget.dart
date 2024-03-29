import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ImageEmptyWidget extends StatelessWidget {
  const ImageEmptyWidget({
    super.key,
    this.height = 200.0,
    this.width = 200.0,
  });

  final double width, height;

  @override
  Widget build(BuildContext context) {
    return LottieBuilder.asset(LottieName.empty, height: height, width: width);
  }
}

class BudgetInImage extends StatelessWidget {
  const BudgetInImage({super.key});
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImageName.budgetInImage,
      width: 100,
      fit: BoxFit.cover,
    );
  }
}
