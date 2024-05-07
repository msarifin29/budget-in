import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/features/onboarding/presentation/bloc/update_max_budget/update_max_budget_bloc.dart';
import 'package:budget_in/injection.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class MaxBudgetWidget extends StatelessWidget {
  const MaxBudgetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: (Theme.of(context).brightness == Brightness.light
              ? ColorApp.grey20
              : ColorApp.night)),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 15,
      ),
      child: BlocBuilder<GetMaxBudgetBloc, GetMaxBudgetState>(
        builder: (context, state) {
          if (state is GetMaxBudgetLoading) {
            return const CircularLoading();
          } else if (state is GetMaxBudgetFailure) {
            return RefreshButton(
              onPressed: () {
                context.read<GetMaxBudgetBloc>().add(
                      InitialData(
                        accountId: Helpers.getAccountId(),
                        uid: Helpers.getUid(),
                      ),
                    );
              },
            );
          } else if (state is GetMaxBudgetSuccess) {
            final data = state.response.data;
            String max = NumberFormat.currency(
                    locale: 'ID', symbol: '', decimalDigits: 0)
                .format(data.maxBudget);

            final value = data.maxBudget - data.totalExpense;
            String v = NumberFormat.currency(
                    locale: 'ID', symbol: '', decimalDigits: 0)
                .format(value < 0 ? 0 : value);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.l10n.monthly_budget,
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w700,
                          color:
                              (Theme.of(context).primaryColor == ColorApp.green
                                  ? Colors.black
                                  : Colors.grey)),
                    ),
                    Text(
                      'Rp. $max',
                      style: context.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700, color: ColorApp.green),
                    ),
                    Row(
                      children: [
                        Text(
                          context.l10n.remaining_budget,
                          textAlign: TextAlign.center,
                          style: context.textTheme.labelSmall!.copyWith(
                              fontWeight: FontWeight.w400,
                              color: (Theme.of(context).primaryColor ==
                                      ColorApp.green
                                  ? Colors.black
                                  : Colors.grey)),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Rp. $v',
                          style: context.textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                            color: data.totalExpense > data.maxBudget
                                ? ColorApp.red
                                : ColorApp.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                      builder: (context) {
                        return EditMonthlyBudgetWidget(
                          maxBudget: max,
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit_square, color: ColorApp.blue),
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class EditMonthlyBudgetWidget extends StatefulWidget {
  const EditMonthlyBudgetWidget({super.key, required this.maxBudget});
  final String maxBudget;

  @override
  State<EditMonthlyBudgetWidget> createState() =>
      _EditMonthlyBudgetWidgetState();
}

class _EditMonthlyBudgetWidgetState extends State<EditMonthlyBudgetWidget> {
  final textControl = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    textControl.text = widget.maxBudget;
    super.initState();
  }

  @override
  void dispose() {
    textControl.dispose();
    super.dispose();
  }

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    symbol: '',
    decimalDigits: 0,
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateMaxBudgetBloc(
        usecase: sl<UpdateMaxBudgetUsecase>(),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Form(
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FormWidget(
                title: context.l10n.monthly_budget,
                hint: widget.maxBudget,
                controller: textControl,
                keyboardType: TextInputType.number,
                inputFormatters: [formatter],
                style: context.textTheme.titleSmall!.copyWith(
                  color: ColorApp.green,
                  fontWeight: FontWeight.w600,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.empty_monthly_budget;
                  }
                  return null;
                },
              ),
              BlocConsumer<UpdateMaxBudgetBloc, UpdateMaxBudgetState>(
                listener: (context, state) {
                  if (state is UpdateMaxBudgetFailure) {
                    Navigator.pop(context);
                    context.scaffoldMessenger.showSnackBar(
                      floatingSnackBar(
                        context,
                        context.l10n.something_wrong,
                      ),
                    );
                  } else if (state is UpdateMaxBudgetSuccess) {
                    Navigator.pop(context);
                    context.scaffoldMessenger.showSnackBar(
                      floatingSnackBar(
                        context,
                        context.l10n
                            .msg_success_create(context.l10n.monthly_budget),
                      ),
                    );
                    context.read<GetMaxBudgetBloc>().add(InitialData(
                          accountId: Helpers.getAccountId(),
                          uid: Helpers.getUid(),
                        ));
                  }
                },
                builder: (context, state) {
                  if (state is UpdateMaxBudgetLoading) {
                    return const CircularLoading();
                  }
                  return PrimaryButton(
                    text: context.l10n.submit,
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        if (textControl.text.trim() == widget.maxBudget) return;
                        context.read<UpdateMaxBudgetBloc>().add(
                              OnUpdated(
                                param: UpdateMaxBudgetparam(
                                  maxBudget: textControl.text.trim(),
                                ),
                              ),
                            );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
