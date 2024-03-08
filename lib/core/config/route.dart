import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:flutter/material.dart';

class RouteName {
  // Authentication
  static const splashPage = 'splash-page';
  static const onboardingPage = 'onboarding-page';
  static const loginPage = 'login-page';
  static const registerPage = 'register-page';
  static const submitRegisterPage = 'submit-register-page';
  static const profilePage = 'profile-page';
  static const editProfilePage = 'edit-profile-page';
  // Expenses
  static const dashboardPage = 'dashboard-page';
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
