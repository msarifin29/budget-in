import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

class IncomePage extends StatelessWidget {
  static const routeName = RouteName.incomePage;
  const IncomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
          title: context.l10n.income,
          actions: [
            SvgButton(
                image: SvgName.filterWhite,
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) => FilterWidget(
                      onPressedCash: () {},
                      onPressedNonCash: () {},
                    ),
                  );
                }),
            const SizedBox(width: 15.0),
          ],
        ),
      ),
      body: Column(
        children: [
          AmountCardWidget(
            plusMin: '+',
            total: '25000',
            category: context.l10n.salary,
            type: context.l10n.cash,
            date: TimeUtil().today(ddMMyyy, DateTime.now()),
            color: ColorApp.green,
            onTap: () {},
          ),
          const SizedBox(height: 15),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                ),
              ),
              builder: (context) {
                return const NewIncomeWidget();
              });
        },
        tooltip: context.l10n.new_expense,
        backgroundColor: Theme.of(context).cardColor,
        child: const Icon(
          Icons.add_circle_outline,
          color: ColorApp.green,
          size: 40,
        ),
      ),
    );
  }
}

class NewIncomeWidget extends StatefulWidget {
  const NewIncomeWidget({super.key});

  @override
  State<NewIncomeWidget> createState() => _NewIncomeWidgetState();
}

class _NewIncomeWidgetState extends State<NewIncomeWidget> {
  final globalKey = GlobalKey<FormState>();
  final idSelected = ValueNotifier(5);
  final idType = ValueNotifier(2);

  final totalC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final categoryIncomes = [
      ItemChoice(1, context.l10n.busines),
      ItemChoice(2, context.l10n.salary),
      ItemChoice(3, context.l10n.additional_income),
      ItemChoice(4, context.l10n.loan),
      ItemChoice(5, context.l10n.other),
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
                  hint: '',
                  controller: totalC,
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
                    valueListenable: idType,
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
                      children: categoryIncomes
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
