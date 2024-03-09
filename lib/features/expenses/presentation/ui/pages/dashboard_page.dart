// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: inference_failure_on_function_invocation, require_trailing_commas, lines_longer_than_80_chars

import 'package:budget_in/core/helpers/util_date.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  static const routeName = RouteName.dashboardPage;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: ColorApp.green),
    );
    return Scaffold(
      backgroundColor: ColorApp.green,
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: CustomPersistenHeader(expandedHeight: 150.0),
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
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
                      UtilDate.today('yMMMM', DateTime.now()),
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: ColorApp.green,
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 80.0,
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorApp.green),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          child: Column(
                            children: [
                              Text(
                                context.l10n.income,
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "+ Rp. 2.000.000",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: ColorApp.green),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 80.0,
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
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
                                style: context.textTheme.bodySmall!.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              Text(
                                "- Rp. 500.000",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: ColorApp.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BoxFeaturewidget(
                          image: SvgName.expense,
                          title: context.l10n.expense,
                          colorFilter: ColorApp.red,
                          onPressed: () {
                            Navigator.pushNamed(context, RouteName.expensePage);
                          },
                        ),
                        BoxFeaturewidget(
                          image: SvgName.income,
                          title: context.l10n.income,
                          colorFilter: ColorApp.green,
                          onPressed: () {},
                        ),
                        BoxFeaturewidget(
                          image: SvgName.creditSync,
                          title: context.l10n.credit,
                          colorFilter: ColorApp.red,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const CustomCarouselWidget(),
                    const SizedBox(height: 20.0),
                    Text(
                      'Sponsors',
                      style: context.textTheme.bodyMedium!
                          .copyWith(color: ColorApp.green),
                    ),
                    const SizedBox(height: 15.0),
                    Wrap(
                      spacing: 35.0,
                      children: [
                        SvgPicture.asset(SvgName.bank, width: 40.0),
                        SvgPicture.asset(SvgName.income, width: 40.0),
                        SvgPicture.asset(SvgName.currencyCircle, width: 40.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
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
                            color: ColorApp.grey20,
                            borderRadius: BorderRadius.circular(15.0)),
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

class CustomPersistenHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  CustomPersistenHeader({required this.expandedHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.none,
      children: [
        Container(
          color: ColorApp.green,
          height: expandedHeight,
          width: double.infinity,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(top: expandedHeight / 4),
          child: Text(
            'Bang Toyip',
            style: context.textTheme.bodyLarge!.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Center(
          child: Opacity(
              opacity: shrinkOffset / expandedHeight,
              child: Container(color: ColorApp.green)),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 22,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Card(
              elevation: 10,
              child: Container(
                height: expandedHeight - 10,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContentBalanceWidget(
                      image: SvgName.bank,
                      title: context.l10n.balance,
                      subtitle: 'Rp. 2.000.000',
                      visibility: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.visibility_outlined,
                          color: ColorApp.green,
                        ),
                      ),
                    ),
                    ContentBalanceWidget(
                      image: SvgName.wallet,
                      title: context.l10n.cash,
                      subtitle: 'Rp. 500.000',
                      visibility: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.visibility_off_outlined,
                          color: ColorApp.green,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class ContentBalanceWidget extends StatelessWidget {
  const ContentBalanceWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.visibility,
  });
  final String image;
  final String title;
  final String subtitle;
  final Widget visibility;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            children: [
              SvgPicture.asset(
                image,
                height: 40.0,
                width: 40.0,
              ),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: context.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        visibility
      ],
    );
  }
}
