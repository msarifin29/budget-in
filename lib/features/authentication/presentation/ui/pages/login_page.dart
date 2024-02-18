// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
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
                    icon: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value == '') {
                        return Strings.emptyEmail;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ValueListenableBuilder(
                    valueListenable: isObscureText,
                    builder: (context, value, _) {
                      return FormWidget(
                        title: Strings.password,
                        hint: Strings.inputPassword,
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
                            return Strings.emptyPassword;
                          } else if (value.length < 8) {
                            return Strings.passwordToShort;
                          }
                          return null;
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 75),
                  PrimaryButton(
                    text: Strings.signIn,
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
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(Strings.alreadyAccount),
                    PrimaryTextButton(
                      text: Strings.createAccount,
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
                const SizedBox(height: 10),
                PrimaryTextButton(
                  text: Strings.forgotPassword,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
