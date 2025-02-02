// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/injection.dart';

import 'authentication/authentication.dart';
import 'expenses/expenses.dart';
import 'incomes/incomes.dart';

class NewBloc extends StatelessWidget {
  const NewBloc({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) =>
              AccountBloc(accountUsecase: sl<AccountUsecase>()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              ExpenseBloc(createExpenseUsecase: sl<CreateExpenseUsecase>()),
        ),
        BlocProvider(
          lazy: false,
          create: (context) =>
              GetExpensesBloc(getExpensesUsecase: sl<GetExpensesUsecase>()),
        ),
        BlocProvider(create: (context) => sl<GetMonthlyReportBloc>()),
        BlocProvider(create: (context) => sl<MonthlyReportDetailBloc>()),
        BlocProvider(
          create: (context) =>
              UpdateExpenseBloc(usecase: sl<UpdateExpensesUsecase>()),
        ),
        BlocProvider(
          create: (context) =>
              CreateIncomeBloc(usecase: sl<CreateIncomeUsecase>()),
        ),
        BlocProvider(
          create: (context) => GetIncomeBloc(usecase: sl<GetIncomesUsecase>()),
        ),
        BlocProvider(
          create: (context) =>
              GetMaxBudgetBloc(usecase: sl<GetMaxBudgetUsecase>()),
        ),
        BlocProvider(create: (context) => sl<PrivacyBloc>()),
        BlocProvider(create: (context) => sl<BankBloc>()),
        BlocProvider(create: (context) => sl<MonthlyReportCategoryBloc>()),
        BlocProvider(create: (context) => sl<MonthlyReportDashboardBloc>()),
      ],
      child: child,
    );
  }
}
