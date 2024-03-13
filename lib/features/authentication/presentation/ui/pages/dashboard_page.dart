// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: inference_failure_on_function_invocation, require_trailing_commas, lines_longer_than_80_chars

import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/presentation/ui/widgets/line_chart_widget.dart';
import 'package:budget_in/l10n/l10n.dart';

import '../../bloc/show_total/show_total_cubit.dart';

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
    getAccount();
    super.initState();
  }

  void getAccount() {
    context.read<AccountBloc>().add(OnInitialAccount(uid: uid));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Theme.of(context).primaryColor),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
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

class CustomPersistenHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  CustomPersistenHeader({required this.expandedHeight});
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    String total(String v, bool isVisible) {
      if (isVisible == true) {
        return v;
      }
      return Helpers.replaceString(v);
    }

    return BlocProvider(
      create: (context) => ShowTotalCubit()..showBalance(true),
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: expandedHeight,
            width: double.infinity,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: expandedHeight / 4),
            child: Text(
              'Budget In',
              style: context.textTheme.bodyLarge!.copyWith(
                color: (Theme.of(context).brightness == Brightness.light
                    ? Colors.white
                    : Colors.grey),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Center(
            child: Opacity(
                opacity: shrinkOffset / expandedHeight,
                child: Container(color: Theme.of(context).primaryColor)),
          ),
          Positioned(
            top: expandedHeight / 2 - shrinkOffset,
            left: MediaQuery.of(context).size.width / 22,
            child: Opacity(
              opacity: (1 - shrinkOffset / expandedHeight),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 10,
                child: Container(
                  height: expandedHeight - 10,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(20.0),
                  child: BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      log('account => //');
                      if (state is AccountSuccess) {
                        final data = state.accountData;
                        final balance = NumberFormat.currency(
                                locale: 'ID', symbol: '', decimalDigits: 0)
                            .format(data.balance);
                        final cash = NumberFormat.currency(
                                locale: 'ID', symbol: '', decimalDigits: 0)
                            .format(data.cash);

                        return BlocBuilder<ShowTotalCubit, bool>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ContentBalanceWidget(
                                  image: SvgName.bank,
                                  title: context.l10n.balance,
                                  subtitle: total(balance, state),
                                  isVisible: state,
                                  onPressed: () {
                                    if (state == true) {
                                      context
                                          .read<ShowTotalCubit>()
                                          .showBalance(false);
                                    } else {
                                      context
                                          .read<ShowTotalCubit>()
                                          .showBalance(true);
                                    }
                                  },
                                ),
                                ContentBalanceWidget(
                                  image: SvgName.wallet,
                                  title: context.l10n.cash,
                                  subtitle: total(cash, state),
                                  isVisible: state,
                                ),
                              ],
                            );
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
    required this.isVisible,
    this.onPressed,
  });
  final String image;
  final String title;
  final String subtitle;
  final bool isVisible;
  final VoidCallback? onPressed;
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
                      color: (Theme.of(context).brightness == Brightness.light
                          ? Colors.black
                          : Colors.grey),
                    ),
                  ),
                  Text(
                    'Rp $subtitle',
                    style: context.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: (Theme.of(context).brightness == Brightness.light
                          ? ColorApp.green
                          : Colors.grey),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            isVisible == true
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
            color: ColorApp.green,
          ),
        )
      ],
    );
  }
}
