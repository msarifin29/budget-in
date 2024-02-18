import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton({
    required this.text,
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: context.textTheme.bodyMedium?.copyWith(
          color: ColorApp.blue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
