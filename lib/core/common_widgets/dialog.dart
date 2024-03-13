import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';
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

Future selectedDialog(
  BuildContext context, {
  required Function()? onContinue,
  required String title,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: (Theme.of(context).brightness == Brightness.light
                    ? ColorApp.green
                    : Colors.grey),
              ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PrimaryButton(
                text: context.l10n.no,
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                minSize: const Size(80, 45),
              ),
              PrimaryButton(
                onPressed: onContinue,
                text: context.l10n.yes,
                minSize: const Size(80, 45),
                backgroundColor: ColorApp.red,
              ),
            ],
          ),
        ],
      );
    },
  );
}
