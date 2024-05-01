// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:budget_in/features/credit/credits.dart';
import 'package:budget_in/injection.dart';
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentCreditWidget extends StatelessWidget {
  static const routeName = RouteName.newCreditPage;
  const PaymentCreditWidget({
    super.key,
    required this.id,
    required this.creditId,
  });
  final int id;
  final int creditId;

  @override
  Widget build(BuildContext context) {
    final idPayment = ValueNotifier(0);
    return BlocProvider(
      create: (context) => PayCreditBloc(usecase: sl<PayCreditUsecase>()),
      child: Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Text(
              context.l10n.payment_with,
              style: context.textTheme.bodyMedium!.copyWith(
                color: Colors.green,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 15),
            ValueListenableBuilder(
              valueListenable: idPayment,
              builder: (context, v, _) {
                return Wrap(
                  spacing: 8,
                  children: [
                    ItemChoice(1, context.l10n.cash),
                    ItemChoice(2, context.l10n.non_cash),
                  ]
                      .map(
                        (e) => ChoiceChip(
                          label: Text(e.label),
                          selected: idPayment.value == e.id,
                          onSelected: (_) => idPayment.value = e.id,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: BlocConsumer<PayCreditBloc, PayCreditState>(
                listener: (context, state) {
                  log('kong state $state');
                  if (state is PayCreditFailure) {
                    context.scaffoldMessenger.showSnackBar(
                      floatingSnackBar(context, context.l10n.try_again_later),
                    );
                    Navigator.pop(context);
                  } else if (state is PayCreditSuccess) {
                    context.scaffoldMessenger.showSnackBar(
                      floatingSnackBar(context, 'Success'),
                    );
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is PayCreditLoading) {
                    return const CircularLoading();
                  }
                  return PrimaryButton(
                    text: context.l10n.submit,
                    backgroundColor: ColorApp.green,
                    onPressed: () {
                      if (idPayment.value == 0) return;
                      final params = UpdateCreditParams(
                        uid: Helpers.getUid(),
                        creditId: creditId,
                        id: id,
                        typePayment: idPayment.value == 1
                            ? ConstantType.cash
                            : ConstantType.debit,
                        accountId: Helpers.getAccountId(),
                      );
                      context
                          .read<PayCreditBloc>()
                          .add(InitialPaymentEvent(params: params));
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
