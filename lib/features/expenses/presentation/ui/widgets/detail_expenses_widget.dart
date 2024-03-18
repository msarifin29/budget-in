// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailExpensesWidget extends StatelessWidget {
  const DetailExpensesWidget({super.key, required this.data});

  final ExpenseData data;

  @override
  Widget build(BuildContext context) {
    final date = TimeUtil().today(
        ddMMyyy, DateTime.parse(data.createdAt ?? '2012-12-12T15:54:11Z'));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          InfoWidget(
              k: context.l10n.type_x(context.l10n.expense),
              v: ': ${data.expenseType == ConstantType.cash ? context.l10n.cash : context.l10n.non_cash}'),
          InfoWidget(k: context.l10n.date, v: ': $date'),
          InfoWidget(
              k: context.l10n.total,
              v: ':- Rp. ${Helpers.currency(data.total)}'),
          InfoWidget(k: context.l10n.category, v: ': ${data.category}'),
          InfoWidget(k: context.l10n.notes, v: ': ${data.notes}'),
          const SizedBox(height: 20),
          BlocConsumer<UpdateExpenseBloc, UpdateExpenseState>(
            listener: (context, state) {
              log('UpdateExpense $state');
              if (state is UpdateExpenseFailure) {
                context.scaffoldMessenger.showSnackBar(floatingSnackBar(
                    context, context.l10n.failed_cancel_expense));
                Navigator.pop(context);
              } else if (state is UpdateExpenseSuccess) {
                context.scaffoldMessenger.showSnackBar(floatingSnackBar(
                    context, context.l10n.success_cancel_expense));
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is UpdateExpenseLoading) {
                return const CircularLoading();
              }
              return PrimaryButton(
                text: context.l10n.cancel_expense,
                onPressed: () {
                  context.read<UpdateExpenseBloc>().add(
                        CancelExpense(
                          id: data.id,
                          expenseType: data.expenseType == ConstantType.cash
                              ? ConstantType.cash
                              : ConstantType.debit,
                          accountId: Helpers.getAccountId(),
                        ),
                      );
                },
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
