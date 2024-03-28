// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:budget_in/l10n/l10n.dart';

class HistoriesCreditPage extends StatefulWidget {
  static const routeName = RouteName.historiesCreditPage;
  const HistoriesCreditPage({
    super.key,
    required this.creditId,
  });
  final int creditId;
  @override
  State<HistoriesCreditPage> createState() => _HistoriesCreditPageState();
}

class _HistoriesCreditPageState extends State<HistoriesCreditPage> {
  final currentpage = ValueNotifier<int>(1);
  // Controller
  final PagingController<int, HistoryCredit> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    pagingController.addPageRequestListener((pageKey) {
      currentpage.value = pageKey;
      context.read<GetHistoriesCreditBloc>().add(
            InitialHistoriesEvent(
              params: GetHistorisCreditParams(
                page: currentpage.value,
                totalPage: 10,
                creditId: widget.creditId,
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
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<GetHistoriesCreditBloc, GetHistoriesCreditState>(
        listener: (context, state) {
          if (state is GetHistoriesCreditSuccess) {
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
          } else if (state is GetHistoriesCreditFailure) {
            pagingController.error = state.message;
          }
        },
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.9,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
            child: PagedListView<int, HistoryCredit>(
              pagingController: pagingController,
              builderDelegate:
                  PagedChildBuilderDelegate(itemBuilder: (context, h, i) {
                final status = h.status == 'completed'
                    ? context.l10n.completed
                    : context.l10n.active;
                return Column(
                  children: [
                    const SizedBox(height: 5),
                    Container(
                      height: 120,
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(color: ColorApp.green),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InfoSmallWidget(
                                  k: context.l10n.installment,
                                  v: ': ${context.l10n.st(h.th)}'),
                              InfoSmallWidget(
                                  k: context.l10n.total, v: ': Rp. ${h.total}'),
                              InfoSmallWidget(
                                  k: context.l10n.due_date,
                                  v: ': ${TimeUtil().today(monthDay, DateTime.now())}'),
                              InfoSmallWidget(k: 'Status', v: ': $status'),
                            ],
                          ),
                          h.status == 'active'
                              ? MaterialButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return PaymentCreditWidget(
                                          id: h.id,
                                          creditId: h.creditId,
                                        );
                                      },
                                    );
                                  },
                                  color: ColorApp.green,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    context.l10n.pay_now,
                                    style:
                                        context.textTheme.labelSmall!.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                )
                              : const CompletedWidget(),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const GreenLineWidget(),
                    const SizedBox(height: 10),
                  ],
                );
              }, firstPageProgressIndicatorBuilder: (context) {
                return const CircularLoading();
              }, firstPageErrorIndicatorBuilder: (context) {
                return ErrorImageWidget(text: pagingController.error);
              }, newPageErrorIndicatorBuilder: (context) {
                return ErrorImageWidget(text: pagingController.error);
              }, noItemsFoundIndicatorBuilder: (context) {
                return EmptyWidget(text: context.l10n.empty_expense_msg);
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class GreenLineWidget extends StatelessWidget {
  const GreenLineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: MediaQuery.sizeOf(context).width * 0.3,
      color: ColorApp.green,
    );
  }
}

class CompletedWidget extends StatelessWidget {
  const CompletedWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 110,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.grey, borderRadius: BorderRadius.circular(15)),
      child: Text(
        context.l10n.completed,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
