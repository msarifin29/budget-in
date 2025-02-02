import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class NewAppBarWidget extends StatelessWidget {
  const NewAppBarWidget(
      {super.key, required this.title, this.actions, this.leading = false});
  final String title;
  final List<Widget>? actions;
  final bool leading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: Text(
        title,
        style: context.textTheme.bodyLarge!.copyWith(
          color: (Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : Colors.grey),
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: actions,
      leading: leading
          ? IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            )
          : const SizedBox.shrink(),
    );
  }
}
