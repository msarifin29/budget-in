import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:budget_in/features/expenses/presentation/ui/pages/expense_page.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:flutter/material.dart';

class RouteName {
  // Authentication
  static const initialPage = '/';
  static const splashPage = 'splash-page';
  static const accountPage = 'account-page';
  static const onboardingPage = 'onboarding-page';
  static const loginPage = 'login-page';
  static const registerPage = 'register-page';
  static const submitRegisterPage = 'submit-register-page';
  static const profilePage = 'profile-page';
  static const editProfilePage = 'edit-profile-page';
  static const forgotPasswordPage = 'forgot-password-page';
  static const resetPasswordPage = 'reset-password-page';
  static const mainPage = 'main-page';
  static const monthlyReportPage = 'monthly-report-page';
  static const monthlyReportDetailPage = 'monthly-report-detail-page';
  static const privacyPolicePage = 'privacy-police-page';
  // Expenses
  static const dashboardPage = 'dashboard-page';
  static const expensePage = 'expense-page';
  static const newExpensePage = 'new-expense-page';
  // Incomes
  static const incomePage = 'income-page';
  static const newIncomePage = 'new-income-page';
  // Credits
  static const creditPage = 'credit-page';
  static const newCreditPage = 'new-credit-page';
  static const historiesCreditPage = 'histories-credit-page';
}

class NamedArguments {
  static const currentIndex = 'current-index';
  static const username = 'username';
  static const email = 'email';
  static const password = 'password';
  static const isRegister = 'is-register';
  static const creditId = 'credit-id';
  static const accountData = 'account-data';
  static const data = 'data';
  static const year = 'year';
  static const month = 'month';
}

class AppRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DashboardPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const DashboardPage();
          },
        );

      case ResetPasswordPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const ResetPasswordPage();
          },
        );

      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginPage();
          },
        );

      case ProfilePage.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        final data = arguments[NamedArguments.accountData] as AccountData;
        return MaterialPageRoute(
          builder: (context) {
            return ProfilePage(data: data);
          },
        );

      case RegisterPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const RegisterPage();
          },
        );

      case SubmitRegisterPage.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        final username = arguments[NamedArguments.username] as String;
        final email = arguments[NamedArguments.email] as String;
        final password = arguments[NamedArguments.password] as String;
        return MaterialPageRoute(
          builder: (context) {
            return SubmitRegisterPage(
              username: username,
              email: email,
              password: password,
            );
          },
        );
      case ExpensePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const ExpensePage();
          },
        );
      case IncomePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const IncomePage();
          },
        );

      case ForgotPasswordpage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgotPasswordpage();
          },
        );
      case AccountPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const AccountPage();
          },
        );
      case NewExpensePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const NewExpensePage();
          },
        );
      case NewIncomePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const NewIncomePage();
          },
        );
      case MainPage.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        final currentIndex = arguments[NamedArguments.currentIndex] as int;
        return MaterialPageRoute(
          builder: (context) {
            return MainPage(currentIndex: currentIndex);
          },
        );
      case OnboardingPage.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        final isRegister = arguments[NamedArguments.isRegister] as bool;
        return MaterialPageRoute(
          builder: (context) {
            return OnboardingPage(isRegister: isRegister);
          },
        );

      case MonthlyReportPage.routeName:
        // final arguments = settings.arguments as Map<String, dynamic>;
        // final data = arguments[NamedArguments.data] as List<MonthlyReportData>;
        return MaterialPageRoute(
          builder: (context) {
            return const MonthlyReportPage();
          },
        );
      case MonthlyReportDetailPage.routeName:
        final arguments = settings.arguments as Map<String, dynamic>;
        final year = arguments[NamedArguments.year] as int;
        final month = arguments[NamedArguments.month] as int;
        return MaterialPageRoute(
          builder: (context) {
            return MonthlyReportDetailPage(year: year, month: month);
          },
        );
      case PrivacyPolicePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const PrivacyPolicePage();
          },
        );

      case SplashPage.routeName:
        return MaterialPageRoute(
          builder: (context) => const SplashPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Text(
                'Page not found 404',
              ),
            ),
          ),
        );
    }
  }
}
