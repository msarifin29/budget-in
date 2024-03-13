import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class RefreshButton extends StatelessWidget {
  const RefreshButton({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sync,
            color: (Theme.of(context).brightness == Brightness.light
                ? ColorApp.green
                : Colors.grey),
          ),
          Text(
            'Refresh',
            style: context.textTheme.bodySmall!.copyWith(
              fontWeight: FontWeight.w400,
              color: (Theme.of(context).brightness == Brightness.light
                  ? ColorApp.green
                  : Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
