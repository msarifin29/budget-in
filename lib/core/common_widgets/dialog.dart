import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

Future<T?> simpleBackDialog<T>(
    {required BuildContext context, required String message}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorApp.green,
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                context.l10n.back,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future selectedDialog(
  BuildContext context, {
  required Function()? onContinue,
  required String image,
  required String title,
  required Color color,
  double width = 65,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            const SizedBox(height: 20),
            SvgPicture.asset(
              image,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              width: width,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: (Theme.of(context).brightness == Brightness.light
                        ? ColorApp.green
                        : Colors.grey),
                  ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              PrimaryOutlineButton(
                text: context.l10n.no,
                onPressed: () => Navigator.of(context).pop(false),
                minSize: const Size(80, 45),
              ),
              PrimaryButton(
                onPressed: onContinue,
                text: context.l10n.yes,
                minSize: const Size(80, 45),
                backgroundColor: ColorApp.green,
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

Future confirmDialog(
  BuildContext context, {
  List<Widget>? actions,
  required String image,
  required String title,
  double width = 65,
}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Column(
          children: [
            const SizedBox(height: 20),
            SvgPicture.asset(
              image,
              colorFilter: const ColorFilter.mode(
                ColorApp.green,
                BlendMode.srcIn,
              ),
              width: width,
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: (Theme.of(context).brightness == Brightness.light
                        ? ColorApp.green
                        : Colors.grey),
                  ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        actions: actions,
      );
    },
  );
}
