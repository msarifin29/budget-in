// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: inference_failure_on_function_invocation, require_trailing_commas, lines_longer_than_80_chars

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    context.read<GetMaxBudgetBloc>().add(
          InitialData(
            accountId: Helpers.getAccountId(),
            uid: uid,
          ),
        );
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
                  height: MediaQuery.sizeOf(context).height * 0.93,
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
                          height: MediaQuery.sizeOf(context).height * 0.103),

                      const MaxBudgetWidget(),
                      const SizedBox(height: 15),
                      const LineChartWidget(),
                      const CustomCarouselWidget(),

                      // Text(
                      //   'Sponsors',
                      //   style: context.textTheme.bodyMedium!
                      //       .copyWith(color: ColorApp.green),
                      // ),

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

class Quote {
  final String text;
  final String image;
  Quote({
    required this.text,
    required this.image,
  });
}

class CustomCarouselWidget extends StatefulWidget {
  const CustomCarouselWidget({super.key});

  @override
  State<CustomCarouselWidget> createState() => _CustomCarouselWidgetState();
}

class _CustomCarouselWidgetState extends State<CustomCarouselWidget> {
  final current = ValueNotifier(0);
  final CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    final items = [
      Quote(text: context.l10n.quote1, image: SvgName.crab1),
      Quote(text: context.l10n.quote2, image: SvgName.crab2),
      Quote(text: context.l10n.quote3, image: SvgName.crab3),
      Quote(text: context.l10n.quote4, image: SvgName.crab4),
    ];

    return ValueListenableBuilder(
        valueListenable: current,
        builder: (context, value, _) {
          return Column(
            children: [
              SizedBox(
                height: 150.0,
                width: double.infinity,
                child: CarouselSlider.builder(
                  itemCount: items.length,
                  carouselController: controller,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: (Theme.of(context).brightness == Brightness.light
                            ? ColorApp.grey20
                            : ColorApp.night),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SvgPicture.asset(items[itemIndex].image, width: 50),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.5,
                            child: Text(
                              items[itemIndex].text,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.clip,
                              style: context.textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.w500,
                                color: (Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.blue
                                    : Colors.green),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  options: CarouselOptions(
                    height: 120,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    // autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    autoPlayAnimationDuration: const Duration(seconds: 10),
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
