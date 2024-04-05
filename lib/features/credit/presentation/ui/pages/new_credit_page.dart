// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:budget_in/l10n/l10n.dart';

class NewCreditPage extends StatefulWidget {
  static const routeName = RouteName.newCreditPage;
  const NewCreditPage({super.key});

  @override
  State<NewCreditPage> createState() => _NewCreditPageState();
}

class _NewCreditPageState extends State<NewCreditPage> {
  final globalKey = GlobalKey<FormState>();
  final category = ValueNotifier(ItemChoice(0, ''));
  final idType = ValueNotifier(ItemChoice(0, ''));
  final endDate = ValueNotifier('');
  final startDate = ValueNotifier('');

  final totalC = TextEditingController();
  final startDateC = TextEditingController();
  final endDateC = TextEditingController();

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    symbol: '',
    decimalDigits: 0,
  );

  void submit() {
    CreateCreditParams params = CreateCreditParams(
      uid: Helpers.getUid(),
      categoryId: category.value.id,
      typeCredit: 'monthly',
      startDate: startDateC.text,
      installment: totalC.text.trim(),
      endDate: endDateC.text,
    );
    context.read<CreateCreditBloc>().add(OnCreated(params: params));
  }

  @override
  Widget build(BuildContext context) {
    final categoryCredits = [
      ItemChoice(1, context.l10n.other),
      ItemChoice(2, context.l10n.electronic),
      ItemChoice(3, 'Handphone'),
      ItemChoice(4, 'Laptop'),
      ItemChoice(5, context.l10n.motorcycle),
      ItemChoice(6, context.l10n.car),
      ItemChoice(7, context.l10n.property),
      ItemChoice(8, context.l10n.furniture),
      ItemChoice(9, context.l10n.kitchen_set),
      ItemChoice(10, context.l10n.venture_capital),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
          title: context.l10n.new_credit,
          leading: true,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.category,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              ValueListenableBuilder(
                  valueListenable: category,
                  builder: (context, v, _) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  width: double.infinity,
                                  child: Wrap(
                                    spacing: 8,
                                    children: categoryCredits
                                        .map(
                                          (e) => ChoiceChip(
                                            label: Text(e.label),
                                            selected: category.value == e,
                                            onSelected: (_) {
                                              category.value = e;
                                              Navigator.pop(context);
                                            },
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          },
                        );
                      },
                      child: BoxCredit(text: category.value.label),
                    );
                  }),
              const SizedBox(height: 15),
              Text(
                context.l10n.type_x(context.l10n.credit),
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    selected: true,
                    label: Text(context.l10n.monthly),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                )
              ]),
              const SizedBox(height: 20),
              FormWidget(
                title: context.l10n.installment,
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
                style: context.textTheme.titleSmall!.copyWith(
                  color: ColorApp.green,
                  fontWeight: FontWeight.w600,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [formatter],
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
              const SizedBox(height: 8),
              ValueListenableBuilder(
                  valueListenable: startDate,
                  builder: (context, v, _) {
                    return FormWidget(
                      title: context.l10n.start_date,
                      hint: context.l10n.date,
                      controller: startDateC,
                      readOnly: true,
                      onTap: () async {
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2050))
                            .then((v) {
                          if (v != null) {
                            String formattedDate =
                                TimeUtil().today('yyyy-MM-dd', v);
                            startDateC.text = formattedDate;
                          }
                        });
                      },
                      validator: (v) {
                        if (v == null || v == '') {
                          return context.l10n.empty_date;
                        }
                        return null;
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                    );
                  }),
              const SizedBox(height: 15),
              ValueListenableBuilder(
                  valueListenable: endDate,
                  builder: (context, v, _) {
                    return FormWidget(
                      title: context.l10n.end_date,
                      hint: context.l10n.date,
                      controller: endDateC,
                      readOnly: true,
                      onTap: () async {
                        await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2024),
                                lastDate: DateTime(2050))
                            .then((v) {
                          if (v != null) {
                            String formattedDate =
                                TimeUtil().today('yyyy-MM-dd', v);
                            endDateC.text = formattedDate;
                          }
                        });
                      },
                      validator: (v) {
                        if (v == null || v == '') {
                          return context.l10n.empty_date;
                        }
                        return null;
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                    );
                  }),
              const SizedBox(height: 30),
              BlocConsumer<CreateCreditBloc, CreateCreditState>(
                listener: (context, state) {
                  log('kong lol $state');
                  if (state is CreateCreditFailure) {
                    context.scaffoldMessenger.showSnackBar(
                      floatingSnackBar(
                        context,
                        state.message,
                      ),
                    );
                  } else if (state is CreateCreditSuccess) {
                    context.scaffoldMessenger.showSnackBar(
                      floatingSnackBar(
                        context,
                        context.l10n.msg_success_create(context.l10n.credit),
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  if (state is CreateCreditLoading) {
                    return const CircularLoading();
                  }
                  return PrimaryButton(
                    text: context.l10n.submit,
                    onPressed: () {
                      if (category.value.id == 0) {
                        context.scaffoldMessenger.showSnackBar(
                          floatingSnackBar(
                            context,
                            context.l10n
                                .select_category_first(context.l10n.credit),
                          ),
                        );
                      } else if (startDateC.text == '' || endDateC.text == '') {
                        context.scaffoldMessenger.showSnackBar(
                            floatingSnackBar(context, context.l10n.empty_date));
                      } else if (double.parse(
                              totalC.text.replaceAll(RegExp(r'[^0-9]'), '')) <
                          2000) {
                        context.scaffoldMessenger.showSnackBar(
                            floatingSnackBar(context, context.l10n.min_total));
                      } else {
                        submit();
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class BoxCredit extends StatelessWidget {
  const BoxCredit({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey,
        ),
      ),
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(left: 5),
      child: Text(text),
    );
  }
}
