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

class _ExpensePageState extends State<ExpensePage> {
  final currentpage = ValueNotifier<int>(1);
  final PagingController<int, ExpenseData> pagingController =
      PagingController(firstPageKey: 1);
  final not = DateTime.now();

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      currentpage.value = pageKey;
      context.read<GetExpensesBloc>().add(
            OnGetInitialExpenses(
              params: GetExpensesparams(
                page: currentpage.value,
                totalPage: 10,
                status: Helpers.success,
              ),
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
    return RefreshIndicator(
      color: ColorApp.green,
      onRefresh: () {
        onRefresh();
        return Future.delayed(const Duration(milliseconds: 500));
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: NewAppBarWidget(
            title: context.l10n.expense,
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
        body: BlocListener<GetExpensesBloc, GetExpensesState>(
          listener: (context, state) {
            if (state is GetExpensesSuccess) {
              final isLastPage =
                  currentpage.value == state.expenseData.lastPage;
              if (isLastPage) {
                pagingController.appendLastPage(state.expenseData.data);
              } else {
                final nextPageKey = (pagingController.nextPageKey ?? 1) + 1;

                pagingController.appendPage(
                  state.expenseData.data,
                  nextPageKey,
                );
              }
            } else if (state is GetExpensesFailure) {
              pagingController.error = state.message;
            }
          },
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height,
            child: PagedListView<int, ExpenseData>(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate(
                itemBuilder: (context, x, index) {
                  final date = TimeUtil().today(ddMMyyy,
                      DateTime.parse(x.createdAt ?? '2012-12-12T15:54:11Z'));
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
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return DetailExpensesWidget(
                              type: x.expenseType == ConstantType.cash
                                  ? context.l10n.cash
                                  : context.l10n.non_cash,
                              date: date,
                              total: Helpers.currency(x.total),
                              category: x.category,
                              notes: x.notes,
                            );
                          });
                    },
                  );
                },
                firstPageProgressIndicatorBuilder: (context) {
                  return const CircularLoading();
                },
                firstPageErrorIndicatorBuilder: (context) {
                  return Center(
                      child: Text(
                    pagingController.error,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorApp.red.withOpacity(0.4),
                    ),
                  ));
                },
                newPageErrorIndicatorBuilder: (context) {
                  return Center(
                      child: Text(
                    pagingController.error,
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                      color: ColorApp.red.withOpacity(0.4),
                    ),
                  ));
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.newExpensePage);
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

class EmptyExpenseWidget extends StatelessWidget {
  const EmptyExpenseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ImageEmptyWidget(),
          Text(
            context.l10n.empty_expense_msg,
            textAlign: TextAlign.center,
            style: context.textTheme.bodyMedium!.copyWith(
              color: ColorApp.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
