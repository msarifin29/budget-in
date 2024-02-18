import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class DialogBottomSheetWidget extends StatelessWidget {
  const DialogBottomSheetWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Column(
        children: [
          const SizedBox(height: 15),
          IconTextWidget(
            onTap: () {},
            image: SvgName.edit,
            title: Strings.edit,
          ),
          const SizedBox(height: 15),
          IconTextWidget(
            onTap: () {},
            image: SvgName.delete,
            title: Strings.delete,
          ),
        ],
      ),
    );
  }
}
