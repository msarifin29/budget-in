// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:budget_in/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/l10n/l10n.dart';

class CustomPersistenHeader extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final VoidCallback onPressed;

  CustomPersistenHeader({
    required this.expandedHeight,
    required this.onPressed,
  });
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final ssm = sl<SecureStorageManager>();
    String total(String v, bool isVisible) {
      if (isVisible == true) {
        return v;
      }
      return Helpers.replaceString(v);
    }

    void deleteToken() async {
      return await ssm.deleteToken();
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
                child: BlocConsumer<AccountBloc, AccountState>(
                  listener: (context, state) {
                    if (state is AccountFailre) {
                      final statusCode = state.code ?? 0;
                      if (statusCode == 401) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, LoginPage.routeName, (route) => false);
                        deleteToken();
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is AccountLoading) {
                      return ShimmerBox(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: expandedHeight - 10);
                    } else if (state is AccountFailre) {
                      return CPBox(
                        height: expandedHeight - 10,
                        child: RefreshButton(
                          onPressed: onPressed,
                        ),
                      );
                    } else if (state is AccountSuccess) {
                      final data = state.accountData;
                      final balance = NumberFormat.currency(
                              locale: 'ID', symbol: '', decimalDigits: 0)
                          .format(data.balance);
                      final cash = NumberFormat.currency(
                              locale: 'ID', symbol: '', decimalDigits: 0)
                          .format(data.cash);
                      final accountName = data.accountName ?? '';
                      final bank = accountName.isEmpty
                          ? context.l10n.balance
                          : accountName;
                      return CPBox(
                        height: expandedHeight - 10,
                        color: (Theme.of(context).brightness == Brightness.light
                            ? Colors.white
                            : ColorApp.night),
                        child: BlocBuilder<ShowTotalCubit, bool>(
                          builder: (context, state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ContentBalanceWidget(
                                  image: SvgName.bank,
                                  title: bank,
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
                        ),
                      );
                    }
                    return CPBox(
                      height: expandedHeight - 10,
                      child: const SizedBox(),
                    );
                  },
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

class CPBox extends StatelessWidget {
  const CPBox({
    super.key,
    required this.height,
    required this.child,
    this.color,
  });
  final double height;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: child,
    );
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
              SvgPicture.asset(image, height: 40, width: 40),
              const SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.57,
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        color: (Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : Colors.grey),
                      ),
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
