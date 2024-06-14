// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:budget_in/features/expenses/expenses.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:flutter/material.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ExpensePage extends StatefulWidget {
  static const routeName = RouteName.expensePage;
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage>
    with SingleTickerProviderStateMixin {
  final currentpage = ValueNotifier<int>(1);
  final category = ValueNotifier(ItemChoice(0, ''));
  final selectString = ValueNotifier('');
  final index = ValueNotifier(0);

  // Controller
  final PagingController<int, ExpenseData> pagingController =
      PagingController(firstPageKey: 1);
  // Other
  int selectIndex = 0;
  final not = DateTime.now();
  GetExpensesparams params = const GetExpensesparams();

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      currentpage.value = pageKey;
      context.read<GetExpensesBloc>().add(
            OnGetInitialExpenses(
              params: params.copyWith(page: currentpage.value),
            ),
          );
    });
    super.initState();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void onRefresh() {
    pagingController.refresh();
  }

  void actions(int id, BuildContext context) {
    switch (id) {
      case 1:
        params = const GetExpensesparams();
        pagingController.itemList = [];
        pagingController.appendPage([], 1);
        pagingController.refresh();
        selectString.value = context.l10n
            .empty_filter_expenses('*${context.l10n.empty_expense_msg}*');
      case 2:
        params = const GetExpensesparams();
        params = params.copyWith(expenseType: ConstantType.cash);
        pagingController.itemList = [];
        pagingController.appendPage([], 1);
        pagingController.refresh();
        selectString.value =
            context.l10n.empty_filter_expenses('*${context.l10n.cash}*');
      case 3:
        params = const GetExpensesparams();
        params = params.copyWith(expenseType: ConstantType.debit);
        pagingController.itemList = [];
        pagingController.appendPage([], 1);
        pagingController.refresh();
        selectString.value =
            context.l10n.empty_filter_expenses('*${context.l10n.non_cash}*');
      case 4:
        selectCategory();
      case 5:
        selectDatePicker();
    }
  }

  void selectCategory() async {
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
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                            onSelected: (_) {
                              category.value = e;
                              String ct = context.l10n
                                  .empty_filter_expenses(context.l10n.category);
                              selectString.value =
                                  '$ct *${category.value.label}*';
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
              const SizedBox(height: 30),
              PrimaryButton(
                text: context.l10n.submit,
                onPressed: () {
                  Navigator.pop(context);
                  params = const GetExpensesparams();
                  params = params.copyWith(id: category.value.id);
                  pagingController.itemList = [];
                  pagingController.appendPage([], 1);
                  pagingController.refresh();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void selectDatePicker() async {
    await showDatePicker(
            context: context,
            firstDate: DateTime(2024, 6),
            lastDate: DateTime(2029, 6),
            initialEntryMode: DatePickerEntryMode.calendarOnly)
        .then((date) {
      final stringDate = TimeUtil().today(yyyyMMdd, date ?? DateTime.now());
      params = const GetExpensesparams();
      params = params.copyWith(createdAt: stringDate);
      pagingController.itemList = [];
      pagingController.appendPage([], 1);
      pagingController.refresh();
      final sd = context.l10n.date;
      String textDate = context.l10n.empty_filter_expenses('$sd *$stringDate*');
      selectString.value = textDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final filters = [
      ItemChoice(1, context.l10n.all),
      ItemChoice(2, context.l10n.cash),
      ItemChoice(3, context.l10n.non_cash),
      ItemChoice(4, context.l10n.category),
      ItemChoice(5, context.l10n.date),
    ];

    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      color: ColorApp.green,
      onRefresh: () {
        onRefresh();
        return Future.delayed(const Duration(milliseconds: 500));
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: NewAppBarWidget(title: context.l10n.expense),
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              ContainerFilterWidget(
                  child: ValueListenableBuilder(
                      valueListenable: index,
                      builder: (context, n, _) {
                        return Row(
                          children: [
                            ...filters.map(
                              (e) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: ChoiceChip(
                                    label: Text(e.label),
                                    selected: index.value == e.id,
                                    onSelected: (_) {
                                      index.value = e.id;
                                      actions(index.value, context);
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      })),
              SizedBox(
                height: size.height * 0.8,
                child: BlocListener<GetExpensesBloc, GetExpensesState>(
                  listener: (context, state) {
                    if (state is GetExpensesSuccess) {
                      final isLastPage =
                          currentpage.value == state.expenseData.lastPage;
                      if (isLastPage) {
                        pagingController.appendLastPage(state.expenseData.data);
                      } else {
                        final nextPageKey =
                            (pagingController.nextPageKey ?? 1) + 1;

                        pagingController.appendPage(
                          state.expenseData.data,
                          nextPageKey,
                        );
                      }
                    } else if (state is GetExpensesFailure) {
                      pagingController.error = context.l10n.something_wrong;
                    }
                  },
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: PagedListView<int, ExpenseData>(
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, x, index) {
                          return CardExpenseWidget(
                            data: x,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) =>
                                    DetailExpensesWidget(data: x),
                              );
                            },
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) {
                          return const CircularLoading();
                        },
                        firstPageErrorIndicatorBuilder: (context) {
                          return ErrorImageWidget(text: pagingController.error);
                        },
                        newPageErrorIndicatorBuilder: (context) {
                          return ErrorImageWidget(text: pagingController.error);
                        },
                        noItemsFoundIndicatorBuilder: (context) {
                          return EmptyWidget(text: selectString.value);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.newExpensePage).then((_) {
              params = const GetExpensesparams();
              pagingController.itemList = [];
              pagingController.appendPage([], 1);
              pagingController.refresh();
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
      ),
    );
  }
}
