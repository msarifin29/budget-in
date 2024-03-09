import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class NewAppBarWidget extends StatelessWidget {
  const NewAppBarWidget({
    super.key,
    required this.title,
    this.actions,
  });
  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorApp.green,
      title: Text(
        title,
        style: context.textTheme.bodyLarge!.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: actions,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back, color: Colors.white),
      ),
    );
  }
}
