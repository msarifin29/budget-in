import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class PrimaryTextButton extends StatelessWidget {
  const PrimaryTextButton({
    required this.text,
    super.key,
    this.onPressed,
    this.style,
  });
  final VoidCallback? onPressed;
  final String text;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: style ??
            context.textTheme.bodyMedium?.copyWith(
              color: ColorApp.blue,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}
