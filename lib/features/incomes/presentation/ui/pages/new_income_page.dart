import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
  final date = ValueNotifier<DateTime?>(null);
  final bankName = ValueNotifier<BankModel?>(null);
  final categoryString = ValueNotifier<String>('');

  final dateC = TextEditingController();
  final totalC = TextEditingController();
  final categoryC = TextEditingController();

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    symbol: '+ ',
    decimalDigits: 0,
  );
  @override
  void initState() {
    super.initState();
    context.read<BankBloc>().add(OnInitial());
  }

  void submitIncome() {
    String desiredFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'";
    final bank = bankName.value ?? const BankModel(name: '', code: '');

    String? formattedDate =
        DateFormat(desiredFormat).format(date.value ?? DateTime.now());
    context.read<CreateIncomeBloc>().add(
          InitialCreateEvent(
            uid: Helpers.getUid(),
            categoryId: categorySelected.value.id,
            typeIcome: ConstantType.newConstantType(incomeType.value.id),
            total: totalC.text.trim(),
            accountId: Helpers.getAccountId(),
            createdAt: formattedDate,
            bankName: bank.name,
            bankId: bank.code,
          ),
        );
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

  Future<dynamic> confirmNewIncome() {
    return confirmDialog(context,
        image: SvgName.incomeIcon,
        title: context.l10n.confirm_new(context.l10n.new_income),
        actions: [
          BlocConsumer<CreateIncomeBloc, CreateIncomeState>(
            listener: (context, state) {
              if (state is CreateIncomeSuccess) {
                Navigator.pop(context);
                Navigator.pop(context);
                context.scaffoldMessenger.showSnackBar(
                  floatingSnackBar(
                    context,
                    context.l10n.msg_success_create(context.l10n.income),
                  ),
                );
              } else if (state is CreateIncomeFailed) {
                Navigator.pop(context);
                simpleBackDialog(
                  context: context,
                  message: context.l10n.msg_failed_add_new(context.l10n.income),
                );
              }
            },
            builder: (context, state) {
              if (state is CreateIncomeLoading) {
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
                    onPressed: () => submitIncome(),
                  ),
                ],
              );
            },
          ),
        ]);
  }

  void selectCategory(BuildContext context) async {
    final categoryIncomes = [
      ItemChoice(1, context.l10n.other),
      ItemChoice(2, context.l10n.busines),
      ItemChoice(3, context.l10n.salary),
      ItemChoice(4, context.l10n.additional_income),
      ItemChoice(5, context.l10n.loan),
    ];
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            width: double.infinity,
            child: ValueListenableBuilder(
              valueListenable: categorySelected,
              builder: (context, v, _) {
                return Wrap(
                  spacing: 8,
                  children: categoryIncomes
                      .map(
                        (e) => ChoiceChip(
                          label: Text(e.label),
                          selected: categorySelected.value.id == e.id,
                          onSelected: (_) {
                            categorySelected.value = e;
                            categoryC.text = categorySelected.value.label;
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
                        return Column(
                          children: [
                            Row(
                              children: [
                                ItemChoice(1, context.l10n.cash),
                                ItemChoice(2, context.l10n.non_cash),
                              ]
                                  .map((e) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: ChoiceChip(
                                          label: Text(e.label),
                                          selected: incomeType.value.id == e.id,
                                          onSelected: (_) =>
                                              incomeType.value = e,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                            const SizedBox(height: 15),
                            incomeType.value.id == 1
                                ? const SizedBox.shrink()
                                : const InfoBankWidget(),
                            incomeType.value.id == 1
                                ? const SizedBox.shrink()
                                : const SizedBox(height: 10),
                            incomeType.value.id == 1
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
                                              style: context
                                                  .textTheme.bodyMedium!
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
                      }),
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
                              child: Text(context.l10n.yesterday),
                            ),
                          ),
                        );
                      }),
                  const SizedBox(height: 8),
                  const SizedBox(height: 30),
                  PrimaryButton(
                    text: context.l10n.submit,
                    onPressed: () {
                      if (incomeType.value.id == 0) {
                        context.scaffoldMessenger.showSnackBar(
                          floatingSnackBar(
                              context,
                              context.l10n
                                  .select_type_first(context.l10n.income)),
                        );
                      } else {
                        if (globalKey.currentState!.validate()) {
                          confirmNewIncome();
                        }
                      }
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
