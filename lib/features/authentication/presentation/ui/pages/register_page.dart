import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  static const routeName = RouteName.registerPage;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final isObscureText = ValueNotifier<bool>(true);

  final globalKey = GlobalKey<FormState>();

  final nameControl = TextEditingController();
  final emailControl = TextEditingController();
  final passwordControl = TextEditingController();

  @override
  void dispose() {
    nameControl.dispose();
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
            Form(
              key: globalKey,
              child: Column(
                children: [
                  const LogoWidget(),
                  FormWidget(
                    title: context.l10n.username,
                    hint: context.l10n.username,
                    controller: nameControl,
                    icon: const Icon(
                      Icons.person_outlined,
                      color: ColorApp.green,
                    ),
                    validator: (value) {
                      if (value == null || value == '') {
                        return Strings.emptyName;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
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
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  context.l10n.have_account,
                  style: const TextStyle(color: ColorApp.green),
                ),
                PrimaryTextButton(
                  text: context.l10n.login,
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginPage.routeName,
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 50),
            PrimaryButton(
              text: context.l10n.next,
              onPressed: () {
                if (globalKey.currentState!.validate()) {
                  Navigator.pushNamed(
                    context,
                    SubmitRegisterPage.routeName,
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
