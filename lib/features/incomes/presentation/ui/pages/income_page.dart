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

class _IncomePageState extends State<IncomePage> {
  final currentpage = ValueNotifier<int>(1);
  final PagingController<int, IncomeData> pagingController =
      PagingController(firstPageKey: 1);
  final not = DateTime.now();

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      currentpage.value = pageKey;
      context.read<GetIncomeBloc>().add(
            InitialIncomeEvent(
              params: GetIncomeParams(
                page: currentpage.value,
                totalPage: 10,
              ),
            ),
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
        body: BlocListener<GetIncomeBloc, GetIncomeState>(
          listener: (context, state) {
            if (state is GetIncomeSuccess) {
              final isLastPage = currentpage.value == state.data.lastPage;
              if (isLastPage) {
                pagingController.appendLastPage(state.data.data);
              } else {
                final nextPageKey = (pagingController.nextPageKey ?? 1) + 1;

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
                          categoryId: 1, id: 1, title: context.l10n.other);
                  final date =
                      TimeUtil().today(ddMMyyy, DateTime.parse(x.createdAt));
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: Text(
                      pagingController.error,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorApp.red.withOpacity(0.4),
                      ),
                    )),
                  );
                },
                newPageErrorIndicatorBuilder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: Text(
                      pagingController.error,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorApp.red.withOpacity(0.4),
                      ),
                    )),
                  );
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, NewIncomePage.routeName);
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
