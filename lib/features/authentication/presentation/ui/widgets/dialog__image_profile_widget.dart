import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class DialogImageProfileWidget extends StatelessWidget {
  const DialogImageProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Column(
        children: [
          const SizedBox(height: 15),
          IconTextWidget(
            onTap: () {},
            image: SvgName.view,
            title: Strings.showImage,
          ),
          const SizedBox(height: 15),
          IconTextWidget(
            onTap: () {},
            image: SvgName.camera,
            title: Strings.uploadByCamera,
          ),
          const SizedBox(height: 15),
          IconTextWidget(
            onTap: () {},
            image: SvgName.file,
            title: Strings.uploadByFile,
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
