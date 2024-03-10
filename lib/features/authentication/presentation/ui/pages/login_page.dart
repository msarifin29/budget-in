// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const routeName = RouteName.loginPage;

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final isObscureText = ValueNotifier<bool>(true);

  final globalKey = GlobalKey<FormState>();

  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();

  @override
  void dispose() {
    emailControl.dispose();
    passwordControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const LogoWidget(),
            Form(
              key: globalKey,
              child: Column(
                children: [
                  FormWidget(
                    title: 'Email',
                    hint: Strings.inputEmail,
                    controller: emailControl,
                    keyboardType: TextInputType.emailAddress,
                    icon: const Icon(
                      Icons.email_outlined,
                      color: ColorApp.green,
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return context.l10n.empty_email;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: isObscureText,
                    builder: (context, value, _) {
                      return FormWidget(
                        title: context.l10n.password,
                        hint: context.l10n.input_password,
                        controller: passwordControl,
                        icon: IconButton(
                          onPressed: () {
                            isObscureText.value = !isObscureText.value;
                          },
                          icon: Icon(
                            isObscureText.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: ColorApp.green,
                          ),
                        ),
                        obscureText: isObscureText.value,
                        validator: (value) {
                          if (value == null || value == '') {
                            return context.l10n.empty_password;
                          } else if (value.length < 6) {
                            return context.l10n.password_to_short;
                          }
                          return null;
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(context.l10n.have_account),
                    PrimaryTextButton(
                      text: context.l10n.new_account,
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RegisterPage.routeName,
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
                PrimaryTextButton(
                  text: context.l10n.forgot_password,
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.forgotPasswordPage);
                  },
                ),
              ],
            ),
            const SizedBox(height: 100),
            PrimaryButton(
              text: context.l10n.login,
              onPressed: () {
                if (globalKey.currentState!.validate()) {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    DashboardPage.routeName,
                    (route) => false,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
