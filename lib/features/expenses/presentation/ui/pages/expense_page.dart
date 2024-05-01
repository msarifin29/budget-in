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
  // Controller
  final PagingController<int, ExpenseData> pagingController =
      PagingController(firstPageKey: 1);
  late TabController tabController;
  // Other
  int selectIndex = 0;
  final not = DateTime.now();
  GetExpensesparams params =
      const GetExpensesparams(page: 1, totalPage: 10, status: Helpers.success);
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() => selectIndex = tabController.index);
    });
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

  @override
  Widget build(BuildContext context) {
    // final categoryExpepenses = [
    //   ItemChoice(1, context.l10n.other),
    //   ItemChoice(2, context.l10n.food_and_beverage),
    //   ItemChoice(3, context.l10n.shopping),
    //   ItemChoice(4, context.l10n.transport),
    //   ItemChoice(5, context.l10n.motorcycle_or_car),
    //   ItemChoice(6, context.l10n.traveling),
    //   ItemChoice(7, context.l10n.healty),
    //   ItemChoice(8, context.l10n.cost_and_bill),
    //   ItemChoice(9, context.l10n.education),
    //   ItemChoice(10, context.l10n.sport_and_hoby),
    //   ItemChoice(11, context.l10n.beauty),
    //   ItemChoice(12, context.l10n.work),
    //   ItemChoice(13, context.l10n.food_ingredients),
    // ];
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
        body: Column(
          children: [
            TabBar(
              controller: tabController,
              labelColor: Colors.grey,
              tabAlignment: TabAlignment.center,
              labelStyle: Theme.of(context).textTheme.bodySmall,
              splashFactory: NoSplash.splashFactory,
              automaticIndicatorColorAdjustment: false,
              dividerHeight: 0,
              onTap: (value) {
                switch (value) {
                  case 0:
                    params = params.copyWith(expenseType: '');
                    pagingController.itemList = [];
                    pagingController.appendPage([], 1);
                    pagingController.refresh();
                  case 1:
                    params = params.copyWith(expenseType: ConstantType.cash);
                    pagingController.itemList = [];
                    pagingController.appendPage([], 1);
                    pagingController.refresh();
                  case 2:
                    params = params.copyWith(expenseType: ConstantType.debit);
                    pagingController.itemList = [];
                    pagingController.appendPage([], 1);
                    pagingController.refresh();
                }
              },
              tabs: [
                Tab(
                  text: context.l10n.all,
                ),
                Tab(
                  text: context.l10n.cash,
                ),
                Tab(
                  text: context.l10n.non_cash,
                )
              ],
            ),
            const SizedBox(height: 5),
            // Container(
            //   width: double.infinity,
            //   margin: const EdgeInsets.only(top: 5, right: 5, bottom: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       Text('Filter', style: Theme.of(context).textTheme.bodySmall),
            //       const SizedBox(width: 10),
            //       SvgButton(
            //         image: SvgName.filterWhite,
            //         onTap: () {
            //           showModalBottomSheet(
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.only(
            //                 topLeft: Radius.circular(5),
            //                 topRight: Radius.circular(5),
            //               ),
            //             ),
            //             context: context,
            //             builder: (context) => Container(
            //               width: double.infinity,
            //               padding: const EdgeInsets.symmetric(
            //                 horizontal: 10,
            //                 vertical: 15,
            //               ),
            //               child: Column(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   ValueListenableBuilder(
            //                     valueListenable: category,
            //                     builder: (context, v, _) {
            //                       return Wrap(
            //                         spacing: 8,
            //                         children: categoryExpepenses
            //                             .map(
            //                               (e) => ChoiceChip(
            //                                 label: Text(e.label),
            //                                 selected: category.value.id == e.id,
            //                                 onSelected: (_) =>
            //                                     category.value = e,
            //                                 shape: RoundedRectangleBorder(
            //                                   borderRadius:
            //                                       BorderRadius.circular(25),
            //                                 ),
            //                               ),
            //                             )
            //                             .toList(),
            //                       );
            //                     },
            //                   ),
            //                   const SizedBox(height: 20),
            //                   PrimaryButton(
            //                     text: context.l10n.submit,
            //                     onPressed: () {
            //                       if (category.value.id == 0) return;
            //                       params =
            //                           params.copyWith(id: category.value.id);
            //                       pagingController.itemList = [];
            //                       pagingController.appendPage([], 1);
            //                       pagingController.refresh();
            //                       Navigator.pop(context);
            //                     },
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         },
            //       ),
            //       const SizedBox(width: 15),
            //     ],
            //   ),
            // ),
            Flexible(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    BlocListener<GetExpensesBloc, GetExpensesState>(
                      listener: (context, state) {
                        if (state is GetExpensesSuccess) {
                          final isLastPage =
                              currentpage.value == state.expenseData.lastPage;
                          if (isLastPage) {
                            pagingController
                                .appendLastPage(state.expenseData.data);
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
                            final date = TimeUtil().today(
                                ddMMyyy,
                                DateTime.parse(
                                    x.createdAt ?? '2012-12-12T15:54:11Z'));
                            return AmountCardWidget(
                              plusMin: '-',
                              total: Helpers.currency(x.total),
                              category: x.category,
                              type: x.expenseType == ConstantType.cash
                                  ? context.l10n.cash
                                  : context.l10n.non_cash,
                              date: date,
                              color: x.expenseType == ConstantType.cash
                                  ? ColorApp.green
                                  : ColorApp.blue,
                              colorNumber: ColorApp.red,
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return DetailExpensesWidget(data: x);
                                    });
                              },
                            );
                          }, firstPageProgressIndicatorBuilder: (context) {
                            return const CircularLoading();
                          }, firstPageErrorIndicatorBuilder: (context) {
                            return ErrorImageWidget(
                                text: pagingController.error);
                          }, newPageErrorIndicatorBuilder: (context) {
                            return ErrorImageWidget(
                                text: pagingController.error);
                          }, noItemsFoundIndicatorBuilder: (context) {
                            return EmptyWidget(
                                text: context.l10n.empty_expense_msg);
                          }),
                        ),
                      ),
                    ),
                    BlocListener<GetExpensesBloc, GetExpensesState>(
                      listener: (context, state) {
                        if (state is GetExpensesSuccess) {
                          final isLastPage =
                              currentpage.value == state.expenseData.lastPage;
                          if (isLastPage) {
                            pagingController
                                .appendLastPage(state.expenseData.data);
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
                            final date = TimeUtil().today(
                                ddMMyyy,
                                DateTime.parse(
                                    x.createdAt ?? '2012-12-12T15:54:11Z'));
                            return AmountCardWidget(
                              plusMin: '-',
                              total: Helpers.currency(x.total),
                              category: x.category,
                              type: x.expenseType == ConstantType.cash
                                  ? context.l10n.cash
                                  : context.l10n.non_cash,
                              date: date,
                              color: x.expenseType == ConstantType.cash
                                  ? ColorApp.green
                                  : ColorApp.blue,
                              colorNumber: ColorApp.red,
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return DetailExpensesWidget(data: x);
                                    });
                              },
                            );
                          }, firstPageProgressIndicatorBuilder: (context) {
                            return const CircularLoading();
                          }, firstPageErrorIndicatorBuilder: (context) {
                            return ErrorImageWidget(
                                text: pagingController.error);
                          }, newPageErrorIndicatorBuilder: (context) {
                            return ErrorImageWidget(
                                text: pagingController.error);
                          }, noItemsFoundIndicatorBuilder: (context) {
                            return EmptyWidget(
                                text: context.l10n.empty_expense_msg);
                          }),
                        ),
                      ),
                    ),
                    BlocListener<GetExpensesBloc, GetExpensesState>(
                      listener: (context, state) {
                        if (state is GetExpensesSuccess) {
                          final isLastPage =
                              currentpage.value == state.expenseData.lastPage;
                          if (isLastPage) {
                            pagingController
                                .appendLastPage(state.expenseData.data);
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
                            final date = TimeUtil().today(
                                ddMMyyy,
                                DateTime.parse(
                                    x.createdAt ?? '2012-12-12T15:54:11Z'));
                            return AmountCardWidget(
                              plusMin: '-',
                              total: Helpers.currency(x.total),
                              category: x.category,
                              type: x.expenseType == ConstantType.cash
                                  ? context.l10n.cash
                                  : context.l10n.non_cash,
                              date: date,
                              color: x.expenseType == ConstantType.cash
                                  ? ColorApp.green
                                  : ColorApp.blue,
                              colorNumber: ColorApp.red,
                              onTap: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return DetailExpensesWidget(data: x);
                                    });
                              },
                            );
                          }, firstPageProgressIndicatorBuilder: (context) {
                            return const CircularLoading();
                          }, firstPageErrorIndicatorBuilder: (context) {
                            return ErrorImageWidget(
                                text: pagingController.error);
                          }, newPageErrorIndicatorBuilder: (context) {
                            return ErrorImageWidget(
                                text: pagingController.error);
                          }, noItemsFoundIndicatorBuilder: (context) {
                            return EmptyWidget(
                                text: context.l10n.empty_expense_msg);
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.newExpensePage).then((_) {
              params = params.copyWith(expenseType: '');
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
