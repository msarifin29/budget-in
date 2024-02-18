import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
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
                    title: Strings.name,
                    hint: Strings.inputName,
                    controller: nameControl,
                    icon: const Icon(Icons.person_outlined),
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
                  const SizedBox(height: 50),
                  PrimaryButton(
                    text: Strings.continueText,
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(Strings.alreadyAccount),
                PrimaryTextButton(
                  text: Strings.signIn,
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
          ],
        ),
      ),
    );
  }
}
