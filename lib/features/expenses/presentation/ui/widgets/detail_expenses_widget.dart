// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'dart:developer';

import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailExpensesWidget extends StatelessWidget {
  const DetailExpensesWidget({super.key, required this.data});

  final ExpenseData data;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final category = data.tCategory ?? const TCategory();
    final date = TimeUtil().today(
        ddMMyyy, DateTime.parse(data.createdAt ?? '2012-12-12T15:54:11Z'));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            '-Rp${Helpers.currency(data.total)}',
            style: GoogleFonts.archivoBlack(
              textStyle: context.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: (Theme.of(context).brightness == Brightness.light
                    ? ColorApp.night
                    : ColorApp.snowWhite),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            context.l10n.category,
            style: GoogleFonts.publicSans(
              textStyle: context.textTheme.bodyMedium!,
              color: (Theme.of(context).brightness == Brightness.light
                  ? Colors.black45
                  : ColorApp.grey20),
            ),
          ),
          Text(
            category.title ?? '',
            style: GoogleFonts.publicSans(
              textStyle: context.textTheme.titleMedium!,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            data.expenseType == ConstantType.cash ? context.l10n.type : 'Bank',
            style: GoogleFonts.publicSans(
              textStyle: context.textTheme.bodyMedium!,
              color: (Theme.of(context).brightness == Brightness.light
                  ? Colors.black45
                  : ColorApp.grey20),
            ),
          ),
          Text(
            data.expenseType == ConstantType.cash
                ? context.l10n.cash
                : data.bankName ?? '',
            style: GoogleFonts.publicSans(
              textStyle: context.textTheme.bodyMedium!,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            context.l10n.date,
            style: GoogleFonts.publicSans(
              textStyle: context.textTheme.bodyMedium!,
              color: (Theme.of(context).brightness == Brightness.light
                  ? Colors.black45
                  : ColorApp.grey20),
            ),
          ),
          Text(
            date,
            style: GoogleFonts.publicSans(
              textStyle: context.textTheme.bodyMedium!,
            ),
          ),
          const SizedBox(height: 10),
          data.notes.isEmpty
              ? const SizedBox()
              : Text(
                  context.l10n.notes,
                  style: GoogleFonts.publicSans(
                    textStyle: context.textTheme.bodyMedium!,
                    color: (Theme.of(context).brightness == Brightness.light
                        ? Colors.black45
                        : ColorApp.grey20),
                  ),
                ),
          data.notes.isEmpty
              ? const SizedBox()
              : Text(
                  data.notes,
                  style: GoogleFonts.publicSans(
                    textStyle: context.textTheme.bodyMedium!,
                  ),
                ),
          const SizedBox(height: 30),
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
              return Align(
                alignment: Alignment.center,
                child: PrimaryButton(
                  text: context.l10n.cancel_expense,
                  minSize: Size(width * 0.2, 45),
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
                ),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
