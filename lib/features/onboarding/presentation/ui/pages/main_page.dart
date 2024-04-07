// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:budget_in/features/expenses/presentation/ui/pages/expense_page.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:budget_in/features/onboarding/presentation/bloc/get_max_budget/get_max_budget_bloc.dart';
import 'package:budget_in/injection.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  static const routeName = RouteName.mainPage;
  const MainPage({
    super.key,
    required this.currentIndex,
  });
  final int currentIndex;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  late String uid;
  @override
  void initState() {
    currentIndex = widget.currentIndex;
    uid = Helpers.getUid();
    getAllEvent();
    super.initState();
  }

  final spm = sl<SharedPreferencesManager>();

  void getAllEvent() {
    context.read<AccountBloc>().add(OnInitialAccount(uid: uid));
    log('lol  account id => ${Helpers.getAccountId()} uid => $uid');
    context.read<GetMaxBudgetBloc>().add(
          InitialData(
            accountId: Helpers.getAccountId(),
            uid: uid,
          ),
        );
  }

  void selectedTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final pages = [
    const DashboardPage(),
    const ExpensePage(),
    const IncomePage(),
    const CreditPage(),
    const AccountPage(),
  ];
  @override
  Widget build(BuildContext context) {
    final minWidth = MediaQuery.sizeOf(context).width * 0.07;
    return Builder(builder: (context) {
      return Scaffold(
          body: Center(child: pages.elementAt(currentIndex)),
          bottomNavigationBar: SafeArea(
            child: Material(
              elevation: 20,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: (Theme.of(context).brightness == Brightness.light
                      ? Colors.white
                      : ColorApp.darkPrimary),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      enableFeedback: false,
                      minWidth: minWidth,
                      onPressed: () {
                        setState(() {
                          currentIndex = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgName.home,
                            width: 25,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 0 ? ColorApp.green : Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Dashboard',
                            style: context.textTheme.labelSmall!.copyWith(
                              fontSize: 10,
                              color: currentIndex == 0
                                  ? ColorApp.green
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      enableFeedback: false,
                      minWidth: minWidth,
                      onPressed: () {
                        setState(() {
                          currentIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgName.icon,
                            width: 25,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 1 ? ColorApp.green : Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            context.l10n.expense,
                            style: context.textTheme.labelSmall!.copyWith(
                              fontSize: 10,
                              color: currentIndex == 1
                                  ? ColorApp.green
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      enableFeedback: false,
                      minWidth: minWidth,
                      onPressed: () {
                        setState(() {
                          currentIndex = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgName.incomeIcon,
                            width: 25,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 2 ? ColorApp.green : Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            context.l10n.income,
                            style: context.textTheme.labelSmall!.copyWith(
                              fontSize: 10,
                              color: currentIndex == 2
                                  ? ColorApp.green
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      enableFeedback: false,
                      minWidth: minWidth,
                      onPressed: () {
                        setState(() {
                          currentIndex = 3;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgName.creditIcon,
                            width: 25,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 3 ? ColorApp.green : Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            context.l10n.credit,
                            style: context.textTheme.labelSmall!.copyWith(
                              fontSize: 10,
                              color: currentIndex == 3
                                  ? ColorApp.green
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      enableFeedback: false,
                      minWidth: minWidth,
                      onPressed: () {
                        setState(() {
                          currentIndex = 4;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            SvgName.person,
                            width: 25,
                            colorFilter: ColorFilter.mode(
                              currentIndex == 4 ? ColorApp.green : Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            context.l10n.account,
                            style: context.textTheme.labelSmall!.copyWith(
                              fontSize: 10,
                              color: currentIndex == 4
                                  ? ColorApp.green
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
