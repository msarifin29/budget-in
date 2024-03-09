import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/presentation/ui/widgets/card_credit_widget.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

class CreditPage extends StatelessWidget {
  static const routeName = RouteName.creditPage;
  const CreditPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(title: context.l10n.credit),
      ),
      body: Column(
        children: [
          CardCreditWidget(
            total: 1000000,
            category: context.l10n.electronic,
            type: 'Active',
            startDate: TimeUtil().today(monthYear, DateTime.now()),
            endDate: TimeUtil().today(monthYear, DateTime.now()),
            color: Colors.red,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              builder: (context) {
                return const NewCreditWidget();
              });
        },
        tooltip: context.l10n.new_expense,
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.add_circle_outline,
          color: ColorApp.green,
          size: 40,
        ),
      ),
    );
  }
}

class NewCreditWidget extends StatefulWidget {
  const NewCreditWidget({super.key});

  @override
  State<NewCreditWidget> createState() => _NewCreditWidgetState();
}

class _NewCreditWidgetState extends State<NewCreditWidget> {
  final globalKey = GlobalKey<FormState>();
  final idSelected = ValueNotifier(1);
  final idType = ValueNotifier(1);
  final due = ValueNotifier(1);
  final dp = ValueNotifier(3);

  final totalC = TextEditingController();
  final durations = [3, 6, 9, 12, 18, 24, 30, 36, 48, 50, 62, 120, 240];
  List<DateTime> months = getAllDays(DateTime.now().year, DateTime.now().month);

  static List<DateTime> getAllDays(int year, int month) {
    List<DateTime> days = [];
    int lastDay = DateTime(year, month + 1, 0).day; // Get last day of the month
    for (int day = 1; day <= lastDay; day++) {
      days.add(DateTime(year, month, day));
    }
    return days;
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
    return SingleChildScrollView(
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
                const SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    context.l10n.new_credit,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: ColorApp.green,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  context.l10n.category,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder(
                  valueListenable: idSelected,
                  builder: (context, v, _) {
                    return Wrap(
                      spacing: 8,
                      children: categoryCredits
                          .map(
                            (e) => ChoiceChip(
                              label: Text(e.label),
                              selected: idSelected.value == e.id,
                              onSelected: (_) => idSelected.value = e.id,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  context.l10n.type_x(context.l10n.credit),
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder(
                    valueListenable: idType,
                    builder: (context, v, _) {
                      return Row(
                        children: [ItemChoice(1, context.l10n.monthly)]
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: ChoiceChip(
                                    label: Text(e.label),
                                    selected: idType.value == e.id,
                                    onSelected: (_) => idType.value = e.id,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                const SizedBox(height: 20),
                FormWidget(
                  title: context.l10n.installment,
                  hint: '',
                  controller: totalC,
                ),
                const SizedBox(height: 15),
                Text(
                  context.l10n.due_date,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder(
                    valueListenable: due,
                    builder: (context, v, _) {
                      return Wrap(
                        spacing: 8,
                        children: months
                            .map((e) => ChoiceChip(
                                  label: Text(e.day.toString()),
                                  selected: due.value == e.day,
                                  onSelected: (_) => due.value = e.day,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                const SizedBox(height: 15),
                Text(
                  context.l10n.duration_payments,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder(
                    valueListenable: dp,
                    builder: (context, v, _) {
                      return Wrap(
                        spacing: 8,
                        children: durations
                            .map((e) => ChoiceChip(
                                  label: Text(e.toString()),
                                  selected: dp.value == e,
                                  onSelected: (_) => dp.value = e,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                const SizedBox(height: 30),
                PrimaryButton(
                  text: context.l10n.submit,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
