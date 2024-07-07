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
        // Onboarding
        BlocProvider(create: (context) => sl<AccountBloc>()),
        BlocProvider(create: (context) => sl<GetMonthlyReportBloc>()),
        BlocProvider(create: (context) => sl<MonthlyReportDetailBloc>()),
        BlocProvider(create: (context) => sl<GetMaxBudgetBloc>()),
        BlocProvider(create: (context) => sl<MonthlyReportCategoryBloc>()),
        BlocProvider(create: (context) => sl<MonthlyReportDashboardBloc>()),
        // Expenses
        BlocProvider(create: (context) => sl<ExpenseBloc>()),
        BlocProvider(create: (context) => sl<GetExpensesBloc>()),
        BlocProvider(create: (context) => sl<UpdateExpenseBloc>()),
        // Incomes
        BlocProvider(create: (context) => sl<CreateIncomeBloc>()),
        BlocProvider(create: (context) => sl<GetIncomeBloc>()),
        BlocProvider(create: (context) => sl<CashWithdrawalBloc>()),
        // Account
        BlocProvider(create: (context) => sl<PrivacyBloc>()),
        BlocProvider(create: (context) => sl<BankBloc>()),
      ],
      child: child,
    );
  }
}
