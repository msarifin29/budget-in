import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class IncomePage extends StatefulWidget {
  static const routeName = RouteName.incomePage;
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage>
    with SingleTickerProviderStateMixin {
  final currentpage = ValueNotifier<int>(1);
  // Controller
  final PagingController<int, IncomeData> pagingController =
      PagingController(firstPageKey: 1);
  late TabController tabController;
  // Other
  int selectIndex = 0;
  final not = DateTime.now();
  GetIncomeParams params = const GetIncomeParams(page: 1, totalPage: 10);

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      setState(() => selectIndex = tabController.index);
    });
    pagingController.addPageRequestListener((pageKey) {
      currentpage.value = pageKey;
      context.read<GetIncomeBloc>().add(
            InitialIncomeEvent(
                params: params.copyWith(page: currentpage.value)),
          );
    });
    super.initState();
  }

  void onRefresh() {
    pagingController.refresh();
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
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
          child: NewAppBarWidget(title: context.l10n.income),
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
                    params = params.copyWith(typeIncome: '');
                    pagingController.itemList = [];
                    pagingController.appendPage([], 1);
                    pagingController.refresh();
                  case 1:
                    params = params.copyWith(typeIncome: ConstantType.cash);
                    pagingController.itemList = [];
                    pagingController.appendPage([], 1);
                    pagingController.refresh();
                  case 2:
                    params = params.copyWith(typeIncome: ConstantType.debit);
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
            Flexible(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    BlocListener<GetIncomeBloc, GetIncomeState>(
                      listener: (context, state) {
                        if (state is GetIncomeSuccess) {
                          final isLastPage =
                              currentpage.value == state.data.lastPage;
                          if (isLastPage) {
                            pagingController.appendLastPage(state.data.data);
                          } else {
                            final nextPageKey =
                                (pagingController.nextPageKey ?? 1) + 1;

                            pagingController.appendPage(
                              state.data.data,
                              nextPageKey,
                            );
                          }
                        } else if (state is GetIncomeFailure) {
                          pagingController.error = state.message;
                        }
                      },
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: PagedListView<int, IncomeData>(
                          pagingController: pagingController,
                          builderDelegate: PagedChildBuilderDelegate(
                            itemBuilder: (context, x, index) {
                              CategoryData cData = x.categoryData ??
                                  CategoryData(
                                      categoryId: 1,
                                      id: 1,
                                      title: context.l10n.other);
                              final date = TimeUtil()
                                  .today(ddMMyyy, DateTime.parse(x.createdAt));
                              return AmountCardWidget(
                                plusMin: '+',
                                total: Helpers.currency(x.total),
                                category: cData.title,
                                type: x.typeIncome == ConstantType.cash
                                    ? context.l10n.cash
                                    : context.l10n.non_cash,
                                date: date,
                                color: x.typeIncome == ConstantType.cash
                                    ? ColorApp.green
                                    : ColorApp.blue,
                              );
                            },
                            firstPageProgressIndicatorBuilder: (context) {
                              return const CircularLoading();
                            },
                            firstPageErrorIndicatorBuilder: (context) {
                              return ErrorImageWidget(
                                  text: pagingController.error);
                            },
                            newPageErrorIndicatorBuilder: (context) {
                              return ErrorImageWidget(
                                  text: pagingController.error);
                            },
                            noItemsFoundIndicatorBuilder: (context) {
                              return EmptyWidget(
                                  text: context.l10n.empty_income_msg);
                            },
                          ),
                        ),
                      ),
                    ),
                    BlocListener<GetIncomeBloc, GetIncomeState>(
                      listener: (context, state) {
                        if (state is GetIncomeSuccess) {
                          final isLastPage =
                              currentpage.value == state.data.lastPage;
                          if (isLastPage) {
                            pagingController.appendLastPage(state.data.data);
                          } else {
                            final nextPageKey =
                                (pagingController.nextPageKey ?? 1) + 1;

                            pagingController.appendPage(
                              state.data.data,
                              nextPageKey,
                            );
                          }
                        } else if (state is GetIncomeFailure) {
                          pagingController.error = state.message;
                        }
                      },
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: PagedListView<int, IncomeData>(
                          pagingController: pagingController,
                          builderDelegate: PagedChildBuilderDelegate(
                            itemBuilder: (context, x, index) {
                              CategoryData cData = x.categoryData ??
                                  CategoryData(
                                      categoryId: 1,
                                      id: 1,
                                      title: context.l10n.other);
                              final date = TimeUtil()
                                  .today(ddMMyyy, DateTime.parse(x.createdAt));
                              return AmountCardWidget(
                                plusMin: '+',
                                total: Helpers.currency(x.total),
                                category: cData.title,
                                type: x.typeIncome == ConstantType.cash
                                    ? context.l10n.cash
                                    : context.l10n.non_cash,
                                date: date,
                                color: x.typeIncome == ConstantType.cash
                                    ? ColorApp.green
                                    : ColorApp.blue,
                              );
                            },
                            firstPageProgressIndicatorBuilder: (context) {
                              return const CircularLoading();
                            },
                            firstPageErrorIndicatorBuilder: (context) {
                              return ErrorImageWidget(
                                  text: pagingController.error);
                            },
                            newPageErrorIndicatorBuilder: (context) {
                              return ErrorImageWidget(
                                  text: pagingController.error);
                            },
                            noItemsFoundIndicatorBuilder: (context) {
                              return EmptyWidget(
                                  text: context.l10n.empty_income_msg);
                            },
                          ),
                        ),
                      ),
                    ),
                    BlocListener<GetIncomeBloc, GetIncomeState>(
                      listener: (context, state) {
                        if (state is GetIncomeSuccess) {
                          final isLastPage =
                              currentpage.value == state.data.lastPage;
                          if (isLastPage) {
                            pagingController.appendLastPage(state.data.data);
                          } else {
                            final nextPageKey =
                                (pagingController.nextPageKey ?? 1) + 1;

                            pagingController.appendPage(
                              state.data.data,
                              nextPageKey,
                            );
                          }
                        } else if (state is GetIncomeFailure) {
                          pagingController.error = state.message;
                        }
                      },
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height,
                        child: PagedListView<int, IncomeData>(
                          pagingController: pagingController,
                          builderDelegate: PagedChildBuilderDelegate(
                            itemBuilder: (context, x, index) {
                              CategoryData cData = x.categoryData ??
                                  CategoryData(
                                      categoryId: 1,
                                      id: 1,
                                      title: context.l10n.other);
                              final date = TimeUtil()
                                  .today(ddMMyyy, DateTime.parse(x.createdAt));
                              return AmountCardWidget(
                                plusMin: '+',
                                total: Helpers.currency(x.total),
                                category: cData.title,
                                type: x.typeIncome == ConstantType.cash
                                    ? context.l10n.cash
                                    : context.l10n.non_cash,
                                date: date,
                                color: x.typeIncome == ConstantType.cash
                                    ? ColorApp.green
                                    : ColorApp.blue,
                              );
                            },
                            firstPageProgressIndicatorBuilder: (context) {
                              return const CircularLoading();
                            },
                            firstPageErrorIndicatorBuilder: (context) {
                              return ErrorImageWidget(
                                  text: pagingController.error);
                            },
                            newPageErrorIndicatorBuilder: (context) {
                              return ErrorImageWidget(
                                  text: pagingController.error);
                            },
                            noItemsFoundIndicatorBuilder: (context) {
                              return EmptyWidget(
                                  text: context.l10n.empty_income_msg);
                            },
                          ),
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
            Navigator.pushNamed(context, NewIncomePage.routeName).then((_) {
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
