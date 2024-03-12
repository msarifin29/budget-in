import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

Future<T?> simpleDialog<T>(
    {required BuildContext context, required String title}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: ColorApp.blue,
                fontWeight: FontWeight.w600,
              ),
        ),
      );
    },
  );
}
