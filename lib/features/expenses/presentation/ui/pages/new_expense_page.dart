import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/expenses/expenses.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  final date = ValueNotifier<DateTime?>(null);
  final bankName = ValueNotifier<BankModel?>(null);
  final categoryString = ValueNotifier<String>('');

  final totalC = TextEditingController();
  final notesC = TextEditingController();
  final dateC = TextEditingController();
  final categoryC = TextEditingController();

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    symbol: '',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    context.read<BankBloc>().add(OnInitial());
  }

  void showCupertinoDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: (Theme.of(context).brightness == Brightness.dark
            ? ColorApp.night
            : Colors.white),
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  void submit() {
    String desiredFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'";

    String? formattedDate =
        DateFormat(desiredFormat).format(date.value ?? DateTime.now());
    final bank = bankName.value ?? const BankModel(name: '', code: '');
    context.read<ExpenseBloc>().add(
          CreateExpenseEvent(
            uid: Helpers.getUid(),
            expenseType: ConstantType.newConstantType(expenseType.value.id),
            total: totalC.text.trim(),
            categoryId: category.value.id,
            category: CategoryExpense.newCategoryExpense(category.value.id),
            accountId: Helpers.getAccountId(),
            notes: notesC.text.trim(),
            createdAt: formattedDate,
            bankName: bank.name,
            bankId: bank.code,
          ),
        );
  }

  Future<dynamic> confirmNewExpense() {
    return confirmDialog(context,
        image: SvgName.icon,
        title: context.l10n.confirm_new(context.l10n.new_expense),
        actions: [
          BlocConsumer<ExpenseBloc, ExpenseState>(
            listener: (context, state) {
              if (state is CreateExpenseSuccess) {
                Navigator.pop(context);
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
                Navigator.pop(context);
                if (state.message.contains('invalid input')) {
                  simpleBackDialog(
                      context: context, message: context.l10n.ex_balance_error);
                } else {
                  simpleBackDialog(
                      context: context,
                      message: context.l10n
                          .msg_failed_add_new(context.l10n.expense));
                }
              }
            },
            builder: (context, state) {
              if (state is CreateExpenseLoading) {
                return const CircularLoading();
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PrimaryOutlineButton(
                    text: context.l10n.no,
                    minSize: const Size(100, 40),
                    onPressed: () => Navigator.pop(context),
                  ),
                  PrimaryButton(
                    text: context.l10n.yes,
                    backgroundColor: ColorApp.green,
                    minSize: const Size(100, 40),
                    onPressed: () => submit(),
                  ),
                ],
              );
            },
          ),
        ]);
  }

  void selectCategory(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        builder: (context) {
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
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            width: double.infinity,
            child: ValueListenableBuilder(
              valueListenable: category,
              builder: (context, v, _) {
                return Wrap(
                  spacing: 8,
                  children: categoryExpepenses
                      .map(
                        (e) => ChoiceChip(
                          label: Text(e.label),
                          selected: category.value.id == e.id,
                          onSelected: (_) {
                            category.value = e;
                            categoryC.text = category.value.label;
                            Navigator.pop(context);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
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
                                        onSelected: (_) =>
                                            expenseType.value = e,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 15),
                          expenseType.value.id == 1
                              ? const SizedBox.shrink()
                              : const InfoBankWidget(),
                          expenseType.value.id == 1
                              ? const SizedBox.shrink()
                              : const SizedBox(height: 10),
                          expenseType.value.id == 1
                              ? const SizedBox.shrink()
                              : BlocBuilder<BankBloc, BankState>(
                                  builder: (context, state) {
                                    return DropdownButtonFormField<BankModel>(
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      isExpanded: true,
                                      value: bankName.value,
                                      onChanged: (BankModel? newValue) {
                                        bankName.value = newValue;
                                      },
                                      items: state.bank.map((e) {
                                        return DropdownMenuItem<BankModel>(
                                          value: e,
                                          child: Text(
                                            e.name,
                                            style: context.textTheme.bodyMedium!
                                                .copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    );
                                  },
                                ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              FormWidget(
                title: context.l10n.category,
                hint: '',
                readOnly: true,
                controller: categoryC,
                icon: const Icon(Icons.arrow_drop_down),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n
                        .select_category_first(context.l10n.expense);
                  }
                  return null;
                },
                onTap: () => selectCategory(context),
              ),
              const SizedBox(height: 15),
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
              const SizedBox(height: 10),
              FormWidget(
                title: context.l10n.desc,
                hint: '',
                controller: notesC,
              ),
              const SizedBox(height: 10),
              ValueListenableBuilder(
                  valueListenable: date,
                  builder: (context, v, _) {
                    String stringDate = TimeUtil()
                        .today('d MMMM', date.value ?? DateTime.now());
                    return FormWidget(
                      title: context.l10n.date,
                      hint: stringDate,
                      controller: dateC,
                      readOnly: true,
                      icon: InkWell(
                        onTap: () {
                          showCupertinoDialog(
                            CupertinoDatePicker(
                              initialDateTime: date.value,
                              mode: CupertinoDatePickerMode.date,
                              use24hFormat: true,
                              showDayOfWeek: true,
                              maximumYear: 2050,
                              onDateTimeChanged: (DateTime newDate) {
                                date.value = newDate;
                              },
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100,
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorApp.green),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            context.l10n.yesterday,
                          ),
                        ),
                      ),
                    );
                  }),
              const SizedBox(height: 30),
              PrimaryButton(
                text: context.l10n.submit,
                onPressed: () {
                  if (expenseType.value.id == 0) {
                    context.scaffoldMessenger.showSnackBar(
                      floatingSnackBar(context,
                          context.l10n.select_type_first(context.l10n.expense)),
                    );
                  } else {
                    if (globalKey.currentState!.validate()) {
                      confirmNewExpense();
                    }
                  }
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
