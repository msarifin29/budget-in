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
                color: Colors.grey,
                fontWeight: FontWeight.w500,
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

SnackBar floatingSnackBar(BuildContext context, String message) {
  return SnackBar(
    backgroundColor: Colors.grey,
    dismissDirection: DismissDirection.up,
    behavior: SnackBarBehavior.floating,
    content: Text(
      message,
      style: Theme.of(context)
          .textTheme
          .bodySmall!
          .copyWith(color: ColorApp.darkPrimary),
    ),
    margin: EdgeInsets.only(
      bottom: MediaQuery.of(context).size.height - 150,
      left: 20,
      right: 20,
    ),
  );
}
