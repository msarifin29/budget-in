import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgButton extends StatelessWidget {
  const SvgButton({
    super.key,
    required this.image,
    this.height = 25.0,
    this.width = 25.0,
    required this.onTap,
  });
  final String image;
  final double width, height;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          image,
          width: width,
          height: height,
        ));
  }
}
