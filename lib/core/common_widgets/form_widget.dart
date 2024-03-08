// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    required this.title,
    required this.hint,
    required this.controller,
    super.key,
    this.icon,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.hintStyle,
  });

  final String title;
  final String hint;
  final Widget? icon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: context.textTheme.bodyMedium,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            hintText: hint,
            hintStyle: hintStyle,
            suffixIcon: icon,
            prefixIcon: prefixIcon,
          ),
          obscureText: obscureText,
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
