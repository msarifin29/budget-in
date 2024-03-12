// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'dart:developer';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/injection.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final ssm = sl<SecureStorageManager>();
  final spm = sl<SharedPreferencesManager>();

  @override
  void dispose() {
    emailControl.dispose();
    passwordControl.dispose();
    super.dispose();
  }

  void saveInfoUser(String token, String uid) async {
    await ssm.saveToken(token);
    await spm.putString(SharedPreferencesManager.keyUid, uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(loginUsecase: sl()),
      child: Scaffold(
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
                      Navigator.pushNamed(
                          context, RouteName.forgotPasswordPage);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 100),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteName.mainPage,
                      arguments: {NamedArguments.currentIndex: 0},
                      (route) => false,
                    );
                    saveInfoUser(state.data.token, state.data.user.uid);
                  } else if (state is LoginFailure) {
                    simpleDialog(context: context, title: state.message);
                  }
                },
                builder: (context, state) {
                  log('state => $state');
                  if (state is LoginLoading) {
                    return const CircularLoading();
                  }
                  return PrimaryButton(
                    text: context.l10n.login,
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        context.read<LoginBloc>().add(
                              OnUserLogin(
                                email: emailControl.text.trim(),
                                password: passwordControl.text.trim(),
                              ),
                            );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
