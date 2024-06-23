// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/injection.dart';
import 'package:budget_in/l10n/l10n.dart';

class MonthlyReportDetailPage extends StatefulWidget {
  static const routeName = RouteName.monthlyReportDetailPage;
  const MonthlyReportDetailPage({
    super.key,
    required this.year,
    required this.month,
  });
  final int year;
  final int month;

  @override
  State<MonthlyReportDetailPage> createState() =>
      _MonthlyReportDetailPageState();
}

class _MonthlyReportDetailPageState extends State<MonthlyReportDetailPage> {
  final monthlyReportBloc = sl<MonthlyReportCategoryBloc>();
  String stringMonth() {
    String m = widget.month.toString();
    if (m.length == 1) {
      return '${widget.year}-0$m';
    } else {
      return '${widget.year}-${widget.month}';
    }
  }

  @override
  void initState() {
    monthlyReportBloc.add(InitialCategory(month: stringMonth()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Detail',
            style: context.textTheme.bodyLarge!.copyWith(
              color: (Theme.of(context).brightness == Brightness.light
                  ? Colors.white
                  : Colors.grey),
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          ),
          bottom: TabBar(tabs: [
            Tab(
              child: Text(
                context.l10n.expense,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorApp.grey,
                ),
              ),
            ),
            Tab(
              child: Text(
                context.l10n.income,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorApp.grey,
                ),
              ),
            ),
          ]),
        ),
        body:
            BlocBuilder<MonthlyReportCategoryBloc, MonthlyReportCategoryState>(
          builder: (context, state) {
            if (state is MonthlyReportCategoryLoading) {
              return const CircularLoading();
            } else if (state is MonthlyReportCategoryFailure) {
              return ErrorImageWidget(
                text: context.l10n.something_wrong,
              );
            } else if (state is MonthlyReportCategorySuccess) {
              final data = state.data;
              return TabBarView(
                children: [
                  ChartExpenseWidget(expenses: data.expenses),
                  ChartIncomeWidget(incomes: data.incomes),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class TextColumn extends StatelessWidget {
  const TextColumn({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
