import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

InputDecoration? inputDecoratonTextField({
  required BuildContext context,
}) =>
    InputDecoration(
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: SvgPicture.asset(SvgName.search),
      ),
      filled: true,
      fillColor: ColorApp.grey.withOpacity(0.5),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 10),
      hintStyle: context.textTheme.bodySmall,
      hintText: Strings.searchByType,
    );

InputDecoration? inputDecorationDropdownField() => InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorApp.green,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorApp.green,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorApp.red,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorApp.red,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
    );
