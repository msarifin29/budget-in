import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewExpensePage extends StatefulWidget {
  static const routeName = RouteName.newExpensePage;
  const NewExpensePage({super.key});

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  final globalKey = GlobalKey<FormState>();
  final category = ValueNotifier(ItemChoice(0, ''));
  final expenseType = ValueNotifier(ItemChoice(0, ''));

  final totalC = TextEditingController();
  final notesC = TextEditingController();

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    symbol: '',
    decimalDigits: 0,
  );

  void submit() {
    if (expenseType.value.id == 0) {
      context.scaffoldMessenger.showSnackBar(
        floatingSnackBar(
            context, context.l10n.select_type_first(context.l10n.expense)),
      );
    } else if (category.value.id == 0) {
      context.scaffoldMessenger.showSnackBar(
        floatingSnackBar(
            context, context.l10n.select_category_first(context.l10n.expense)),
      );
    } else {
      if (globalKey.currentState!.validate()) {
        context.read<ExpenseBloc>().add(
              CreateExpenseEvent(
                  uid: Helpers.getUid(),
                  expenseType:
                      ConstantType.newConstantType(expenseType.value.id),
                  total: totalC.text.trim(),
                  categoryId: expenseType.value.id,
                  category:
                      CategoryExpense.newCategoryExpense(category.value.id),
                  accountId: Helpers.getAccountId()),
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryExpepenses = [
      ItemChoice(1, context.l10n.other),
      ItemChoice(2, context.l10n.food_and_beverage),
      ItemChoice(3, context.l10n.shopping),
      ItemChoice(4, context.l10n.transport),
      ItemChoice(5, context.l10n.motorcycle_or_car),
      ItemChoice(6, context.l10n.traveling),
      ItemChoice(7, context.l10n.healty),
      ItemChoice(8, context.l10n.cost_and_bill),
      ItemChoice(9, context.l10n.education),
      ItemChoice(10, context.l10n.sport_and_hoby),
      ItemChoice(11, context.l10n.beauty),
      ItemChoice(12, context.l10n.work),
      ItemChoice(13, context.l10n.food_ingredients),
    ];
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(title: context.l10n.new_expense, leading: true),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              FormWidget(
                title: context.l10n.total,
                hint: '0',
                style: context.textTheme.titleSmall!.copyWith(
                  color: ColorApp.green,
                  fontWeight: FontWeight.w600,
                ),
                controller: totalC,
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
              ),
              FormWidget(
                title: 'Notes',
                hint: '',
                controller: notesC,
              ),
              const SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.type_x(context.l10n.expense),
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ValueListenableBuilder(
                      valueListenable: expenseType,
                      builder: (context, v, _) {
                        return Row(
                          children: [
                            ItemChoice(1, context.l10n.cash),
                            ItemChoice(2, context.l10n.non_cash),
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: ChoiceChip(
                                      label: Text(e.label),
                                      selected: expenseType.value.id == e.id,
                                      onSelected: (_) => expenseType.value = e,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        );
                      }),
                ],
              ),
              const SizedBox(height: 15),
              Column(
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
                      return Wrap(
                        spacing: 8,
                        children: categoryExpepenses
                            .map(
                              (e) => ChoiceChip(
                                label: Text(e.label),
                                selected: category.value.id == e.id,
                                onSelected: (_) => category.value = e,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 30),
              BlocConsumer<ExpenseBloc, ExpenseState>(
                listener: (context, state) {
                  if (state is CreateExpenseSuccess) {
                    Navigator.pop(context);
                    context.scaffoldMessenger.showSnackBar(
                      floatingSnackBar(
                        context,
                        context.l10n.msg_success_create(context.l10n.expense),
                      ),
                    );
                    context.read<AccountBloc>().add(
                          OnInitialAccount(uid: Helpers.getUid()),
                        );
                  } else if (state is CreateExpenseFailure) {
                    context.scaffoldMessenger.showSnackBar(
                      floatingSnackBar(context, state.message),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CreateExpenseLoading) {
                    return const CircularLoading();
                  }
                  return PrimaryButton(
                    text: context.l10n.submit,
                    onPressed: () => submit(),
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
