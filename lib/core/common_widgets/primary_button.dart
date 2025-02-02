import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.text,
    super.key,
    this.onPressed,
    this.minSize = const Size(double.infinity, 50),
    this.backgroundColor,
  });
  final VoidCallback? onPressed;
  final String text;
  final Size minSize;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: minSize,
      ),
      child: Text(
        text,
        style: context.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class PrimaryOutlineButton extends StatelessWidget {
  const PrimaryOutlineButton({
    required this.text,
    super.key,
    this.onPressed,
    this.minSize = const Size(double.infinity, 50),
  });
  final VoidCallback? onPressed;
  final String text;
  final Size minSize;
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: minSize,
      ),
      child: Text(
        text,
        style: context.textTheme.bodyMedium?.copyWith(
          color: ColorApp.red,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
