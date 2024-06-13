// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:budget_in/core/core.dart';
import 'package:flutter_popup/flutter_popup.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    super.key,
    required this.title,
    required this.hint,
    this.icon,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.hintStyle,
    this.inputFormatters,
    this.onChanged,
    this.style,
    this.readOnly = false,
    this.onTap,
    this.onEditingComplete,
    this.isShowPopUp = false,
    this.msg,
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
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final TextStyle? style;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingComplete;
  final bool isShowPopUp;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            isShowPopUp
                ? CustomPopup(
                    barrierColor: Colors.green.withOpacity(0.0),
                    backgroundColor: ColorApp.grey,
                    content: Text(
                      msg ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                    child: const Icon(
                      Icons.error_outline_outlined,
                      color: ColorApp.green,
                      size: 18,
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
        const SizedBox(height: 10),
        TextFormField(
          style: style ?? context.textTheme.bodySmall,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            hintText: hint,
            hintStyle: hintStyle,
            suffixIcon: icon,
            prefixIcon: prefixIcon,
          ),
          onEditingComplete: onEditingComplete,
          readOnly: readOnly,
          onTap: onTap,
          obscureText: obscureText,
          controller: controller,
          maxLines: maxLines,
          validator: validator,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
