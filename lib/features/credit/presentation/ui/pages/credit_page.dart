import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:budget_in/features/credit/presentation/ui/widgets/card_credit_widget.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class CreditPage extends StatefulWidget {
  static const routeName = RouteName.creditPage;
  const CreditPage({super.key});

  @override
  State<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage>
    with SingleTickerProviderStateMixin {
  final currentpage = ValueNotifier<int>(1);
  // Controller
  final PagingController<int, CreditData> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      currentpage.value = pageKey;
      context.read<GetCreditsBloc>().add(
            InitialCreditEvent(
              params: GetCreditParams(
                page: currentpage.value,
                totalPage: 10,
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
          child: NewAppBarWidget(title: context.l10n.credit),
        ),
        body: BlocListener<GetCreditsBloc, GetCreditsState>(
          listener: (context, state) {
            if (state is GetCreditsSuccess) {
              final isLastPage =
                  currentpage.value == state.response.data.lastPage;
              if (isLastPage) {
                pagingController.appendLastPage(state.response.data.data);
              } else {
                final nextPageKey = (pagingController.nextPageKey ?? 1) + 1;

                pagingController.appendPage(
                  state.response.data.data,
                  nextPageKey,
                );
              }
            } else if (state is GetCreditsFailure) {
              pagingController.error = state.message;
            }
          },
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.9,
            child: PagedListView<int, CreditData>(
              pagingController: pagingController,
              builderDelegate:
                  PagedChildBuilderDelegate(itemBuilder: (context, c, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: CardCreditWidget(
                    creditData: c,
                    color: Colors.red,
                    onTap: () {
                      Navigator.pushNamed(
                          context, HistoriesCreditPage.routeName,
                          arguments: {NamedArguments.creditId: c.id});
                    },
                  ),
                );
              }, firstPageProgressIndicatorBuilder: (context) {
                return const CircularLoading();
              }, firstPageErrorIndicatorBuilder: (context) {
                return ErrorImageWidget(text: pagingController.error);
              }, newPageErrorIndicatorBuilder: (context) {
                return ErrorImageWidget(text: pagingController.error);
              }, noItemsFoundIndicatorBuilder: (context) {
                return EmptyWidget(text: context.l10n.empty_credit_msg);
              }),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, NewCreditPage.routeName);
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
