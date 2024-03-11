import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/presentation/ui/pages/account_page.dart';
import 'package:budget_in/features/authentication/presentation/ui/pages/forgot_password_page.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:budget_in/features/expenses/presentation/ui/pages/expense_page.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:flutter/material.dart';

class RouteName {
  // Authentication
  static const splashPage = 'splash-page';
  static const accountPage = 'account-page';
  static const onboardingPage = 'onboarding-page';
  static const loginPage = 'login-page';
  static const registerPage = 'register-page';
  static const submitRegisterPage = 'submit-register-page';
  static const profilePage = 'profile-page';
  static const editProfilePage = 'edit-profile-page';
  static const forgotPasswordPage = 'forgot-password-page';
  // Expenses
  static const dashboardPage = 'dashboard-page';
  static const expensePage = 'expense-page';
  // Incomes
  static const incomePage = 'income-page';
  // Credits
  static const creditPage = 'credit-page';
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

      case EditProfilePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const EditProfilePage();
          },
        );

      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const LoginPage();
          },
        );

      case ProfilePage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const ProfilePage();
          },
        );

      case RegisterPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const RegisterPage();
          },
        );

      case SubmitRegisterPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const SubmitRegisterPage();
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
      case CreditPage.routeName:
        return MaterialPageRoute(
          builder: (context) {
            return const CreditPage();
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
