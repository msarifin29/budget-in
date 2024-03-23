import 'package:budget_in/core/core.dart';
import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageEmptyWidget(),
          Text(
            text,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall!.copyWith(
              color: ColorApp.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ErrorLottieWidget extends StatelessWidget {
  const ErrorLottieWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.sync_problem_sharp, size: 75, color: Colors.grey),
          const SizedBox(height: 20),
          Text(
            text,
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall!.copyWith(
              color: ColorApp.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
