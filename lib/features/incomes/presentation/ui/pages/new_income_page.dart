import 'dart:developer';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewIncomePage extends StatefulWidget {
  static const routeName = RouteName.newIncomePage;
  const NewIncomePage({super.key});

  @override
  State<NewIncomePage> createState() => _NewIncomePageState();
}

class _NewIncomePageState extends State<NewIncomePage> {
  final globalKey = GlobalKey<FormState>();
  final categorySelected = ValueNotifier(ItemChoice(0, ''));
  final incomeType = ValueNotifier(ItemChoice(0, ''));

  final totalC = TextEditingController();

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    symbol: '+ ',
    decimalDigits: 0,
  );

  void submitIncome() {
    if (incomeType.value.id == 0) {
      context.scaffoldMessenger.showSnackBar(
        floatingSnackBar(
            context, context.l10n.select_type_first(context.l10n.income)),
      );
    } else if (categorySelected.value.id == 0) {
      context.scaffoldMessenger.showSnackBar(
        floatingSnackBar(
            context, context.l10n.select_category_first(context.l10n.income)),
      );
    } else {
      if (globalKey.currentState!.validate()) {
        context.read<CreateIncomeBloc>().add(
              InitialCreateEvent(
                uid: Helpers.getUid(),
                categoryIcome: CategoryIncome.newCategoryIncome(
                  categorySelected.value.id,
                ),
                categoryId: categorySelected.value.id,
                typeIcome: ConstantType.newConstantType(incomeType.value.id),
                total: totalC.text.trim(),
                accountId: Helpers.getAccountId(),
              ),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryIncomes = [
      ItemChoice(1, context.l10n.busines),
      ItemChoice(2, context.l10n.salary),
      ItemChoice(3, context.l10n.additional_income),
      ItemChoice(4, context.l10n.loan),
      ItemChoice(5, context.l10n.other),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(title: context.l10n.new_income, leading: true),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      context.l10n.new_income,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorApp.green,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FormWidget(
                    title: context.l10n.total,
                    hint: '0',
                    controller: totalC,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Rp.',
                        style: context.textTheme.bodyLarge!.copyWith(
                          color: ColorApp.green,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [formatter],
                    style: context.textTheme.titleSmall!.copyWith(
                      color: ColorApp.green,
                      fontWeight: FontWeight.w600,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return context.l10n.min_total;
                      } else if (double.parse(
                              value.replaceAll(RegExp(r'[^0-9]'), '')) <
                          2000) {
                        return context.l10n.min_total;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  Text(
                    context.l10n.type_x(context.l10n.income),
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder(
                      valueListenable: incomeType,
                      builder: (context, v, _) {
                        return Row(
                          children: [
                            ItemChoice(1, context.l10n.cash),
                            ItemChoice(2, context.l10n.non_cash),
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ChoiceChip(
                                      label: Text(e.label),
                                      selected: incomeType.value.id == e.id,
                                      onSelected: (_) => incomeType.value = e,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        );
                      }),
                  const SizedBox(height: 15),
                  Text(
                    context.l10n.category,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder(
                    valueListenable: categorySelected,
                    builder: (context, v, _) {
                      return Wrap(
                        spacing: 8,
                        children: categoryIncomes
                            .map(
                              (e) => ChoiceChip(
                                label: Text(e.label),
                                selected: categorySelected.value.id == e.id,
                                onSelected: (_) => categorySelected.value = e,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                  SizedBox(height: MediaQuery.sizeOf(context).height * 0.3),
                  BlocConsumer<CreateIncomeBloc, CreateIncomeState>(
                    listener: (context, state) {
                      log('CreateIncome $state');
                      if (state is CreateIncomeSuccess) {
                        Navigator.pop(context);
                        context.scaffoldMessenger.showSnackBar(
                          floatingSnackBar(
                            context,
                            context.l10n
                                .msg_success_create(context.l10n.income),
                          ),
                        );
                      } else if (state is CreateIncomeFailed) {
                        context.scaffoldMessenger.showSnackBar(
                          floatingSnackBar(context, state.message),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is CreateIncomeLoading) {
                        return const CircularLoading();
                      }
                      return PrimaryButton(
                        text: context.l10n.submit,
                        onPressed: () => submitIncome(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
