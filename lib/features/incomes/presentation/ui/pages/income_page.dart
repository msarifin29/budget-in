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
  final index = ValueNotifier(0);
  final category = ValueNotifier(ItemChoice(0, ''));
  final selectString = ValueNotifier('');

  // Controller
  final pagingController = PagingController<int, IncomeData>(firstPageKey: 1);
  // Other
  int selectIndex = 0;
  final not = DateTime.now();
  GetIncomeParams params = const GetIncomeParams();

  @override
  void initState() {
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

  void actions(int id, BuildContext context) {
    switch (id) {
      case 1:
        params = const GetIncomeParams();
        pagingController.itemList = [];
        pagingController.appendPage([], 1);
        pagingController.refresh();
        selectString.value = context.l10n.empty_income_msg;
      case 2:
        params = const GetIncomeParams();
        params = params.copyWith(typeIncome: ConstantType.cash);
        pagingController.itemList = [];
        pagingController.appendPage([], 1);
        pagingController.refresh();
        selectString.value =
            context.l10n.empty_filter_incomes('*${context.l10n.cash}*');
      case 3:
        params = const GetIncomeParams();
        params = params.copyWith(typeIncome: ConstantType.debit);
        pagingController.itemList = [];
        pagingController.appendPage([], 1);
        pagingController.refresh();
        selectString.value =
            context.l10n.empty_filter_incomes('*${context.l10n.non_cash}*');
    }
  }

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filters = [
      ItemChoice(1, context.l10n.all),
      ItemChoice(2, context.l10n.cash),
      ItemChoice(3, context.l10n.non_cash),
    ];
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
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: BlocListener<GetIncomeBloc, GetIncomeState>(
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
                      pagingController.error = context.l10n.something_wrong;
                    }
                  },
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    child: PagedListView<int, IncomeData>(
                      pagingController: pagingController,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (context, x, index) {
                          return AmountCardWidget(
                            data: x,
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
                          return EmptyWidget(
                            text: selectString.value.isEmpty
                                ? context.l10n.empty_income_msg
                                : selectString.value,
                          );
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
          onPressed: () async {
            final isUpdated =
                await Navigator.pushNamed(context, NewIncomePage.routeName)
                    as bool?;
            if (isUpdated ?? false) {
              pagingController.itemList = [];
              pagingController.appendPage([], 1);
              pagingController.refresh();
            }
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
