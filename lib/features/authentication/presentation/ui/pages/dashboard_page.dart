// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: inference_failure_on_function_invocation, require_trailing_commas, lines_longer_than_80_chars

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/presentation/ui/widgets/line_chart_widget.dart';
import 'package:budget_in/l10n/l10n.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  static const routeName = RouteName.dashboardPage;

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late String uid;

  @override
  void initState() {
    uid = Helpers.getUid();
    super.initState();
  }

  void getAccount() {
    context.read<AccountBloc>().add(OnInitialAccount(uid: uid));
  }

  void getAllData() {
    getAccount();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor),
    );
    return RefreshIndicator(
      color: ColorApp.green,
      onRefresh: () {
        getAllData();
        return Future.delayed(const Duration(milliseconds: 500));
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: CustomPersistenHeader(
                expandedHeight: 150,
                onPressed: getAccount,
              ),
              pinned: true,
            ),
            SliverToBoxAdapter(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                child: Container(
                  height: MediaQuery.sizeOf(context).height,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.1,
                      ),
                      Text(
                        TimeUtil().today('yMMMM', DateTime.now()),
                        textAlign: TextAlign.center,
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorApp.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 60.0,
                            width: MediaQuery.sizeOf(context).width * 0.45,
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorApp.green),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 15,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  context.l10n.income,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.labelSmall!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: (Theme.of(context).primaryColor ==
                                              ColorApp.green
                                          ? Colors.black
                                          : Colors.grey)),
                                ),
                                Text(
                                  "+ Rp. 2.000.000",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorApp.green),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 60,
                            width: MediaQuery.sizeOf(context).width * 0.45,
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 15,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorApp.green),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  context.l10n.expense,
                                  textAlign: TextAlign.center,
                                  style: context.textTheme.labelSmall!.copyWith(
                                      fontWeight: FontWeight.w400,
                                      color: (Theme.of(context).primaryColor ==
                                              ColorApp.green
                                          ? Colors.black
                                          : Colors.grey)),
                                ),
                                Text(
                                  "- Rp. 500.000",
                                  style: context.textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: ColorApp.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),
                      const LineChartWidget(),
                      const CustomCarouselWidget(),
                      // Text(
                      //   'Sponsors',
                      //   style: context.textTheme.bodyMedium!
                      //       .copyWith(color: ColorApp.green),
                      // ),
                      // const SizedBox(height: 15.0),
                      // Wrap(
                      //   spacing: 35.0,
                      //   children: [
                      //     SvgPicture.asset(SvgName.bank, width: 40.0),
                      //     SvgPicture.asset(SvgName.income, width: 40.0),
                      //     SvgPicture.asset(SvgName.currencyCircle, width: 40.0),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomCarouselWidget extends StatefulWidget {
  const CustomCarouselWidget({super.key});

  @override
  State<CustomCarouselWidget> createState() => _CustomCarouselWidgetState();
}

class _CustomCarouselWidgetState extends State<CustomCarouselWidget> {
  final current = ValueNotifier(0);
  final CarouselController controller = CarouselController();
  final items = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: current,
        builder: (context, value, _) {
          return Column(
            children: [
              SizedBox(
                height: 250.0,
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: items.length,
                  carouselController: controller,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              (Theme.of(context).brightness == Brightness.light
                                  ? ColorApp.grey20
                                  : ColorApp.rootBeer),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Text('${items[itemIndex]}'));
                  },
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                    onPageChanged: (index, reason) {
                      current.value = index;
                    },
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: items.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => controller.animateToPage(entry.key),
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : ColorApp.green)
                            .withOpacity(
                                current.value == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        });
  }
}
