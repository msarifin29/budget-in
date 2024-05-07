// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/injection.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  final monthlyReportBloc = sl<MonthlyReportDetailBloc>();
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
    monthlyReportBloc.add(InitialReportDetailEvent(month: stringMonth()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: NewAppBarWidget(title: '', leading: true)),
      body: BlocBuilder<MonthlyReportDetailBloc, MonthlyReportDetailState>(
        builder: (context, state) {
          if (state is MonthlyReportDetailLoading) {
            return const CircularLoading();
          } else if (state is MonthlyReportDetailFailure) {
            return ErrorImageWidget(
              text: context.l10n.something_wrong,
            );
          } else if (state is MonthlyReportDetailSuccess) {
            return SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height,
                child: Column(
                  children: [
                    Text(
                      context.l10n.expense,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorApp.red,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          minWidth: 600,
                          columns: [
                            DataColumn2(
                              label: TextColumn(
                                text: context.l10n.date,
                              ),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label:
                                  TextColumn(text: context.l10n.expense_type),
                            ),
                            const DataColumn2(
                              label: TextColumn(text: 'Total'),
                            ),
                            DataColumn2(
                              label: TextColumn(text: context.l10n.category),
                              size: ColumnSize.L,
                            ),
                            DataColumn2(
                              label: TextColumn(text: context.l10n.desc),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                              state.data.expenses.length, (i) {
                            final item = state.data.expenses[i];
                            final category = item.tCategory;
                            String t = NumberFormat.currency(
                                    locale: 'ID', symbol: '', decimalDigits: 0)
                                .format(item.total);
                            final date = TimeUtil()
                                .today('d MMM', DateTime.parse(item.createdAt));
                            return DataRow(cells: [
                              DataCell(Text(date)),
                              DataCell(Text(item.expenseType)),
                              DataCell(Text('Rp $t')),
                              DataCell(Text(category.title ?? '')),
                              DataCell(Text(item.notes))
                            ]);
                          }),
                        ),
                      ),
                    ),
                    Text(
                      context.l10n.income,
                      style: context.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorApp.green,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          minWidth: 600,
                          columns: [
                            DataColumn2(
                              label: TextColumn(
                                text: context.l10n.date,
                              ),
                              size: ColumnSize.S,
                            ),
                            DataColumn2(
                              label: TextColumn(text: context.l10n.income_type),
                            ),
                            const DataColumn2(
                              label: TextColumn(text: 'Total'),
                            ),
                            DataColumn2(
                              label: TextColumn(text: context.l10n.category),
                              size: ColumnSize.S,
                            ),
                          ],
                          rows: List<DataRow>.generate(
                              state.data.incomes.length, (i) {
                            final item = state.data.incomes[i];
                            final category = item.tCategory;
                            String t = NumberFormat.currency(
                                    locale: 'ID', symbol: '', decimalDigits: 0)
                                .format(item.total);
                            final date = TimeUtil()
                                .today('d MMM', DateTime.parse(item.createdAt));
                            return DataRow(cells: [
                              DataCell(Text(date)),
                              DataCell(Text(item.typeIncome)),
                              DataCell(Text('Rp $t')),
                              DataCell(Text(category.title ?? '')),
                            ]);
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
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
