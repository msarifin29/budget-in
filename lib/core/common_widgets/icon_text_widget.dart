import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    required this.onTap,
    required this.image,
    required this.title,
    super.key,
  });

  final VoidCallback onTap;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorApp.grey,
          ),
          child: Row(
            children: [
              SvgPicture.asset(image),
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
