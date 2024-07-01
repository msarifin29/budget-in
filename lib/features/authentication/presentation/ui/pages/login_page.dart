// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/injection.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:email_validator/email_validator.dart';
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

  void saveInfoUser(String token, String uid, String accountId) async {
    await ssm.saveToken(token);
    await spm.putString(SharedPreferencesManager.keyUid, uid);
    await spm.putString(SharedPreferencesManager.keyAccountId, accountId);
  }

  bool isValidEmail(String email) {
    return EmailValidator.validate(email);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(loginUsecase: sl()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const LogoWidget(),
              Form(
                key: globalKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: FormWidget(
                        title: 'Email',
                        hint: 'user@mail.com',
                        controller: emailControl,
                        keyboardType: TextInputType.emailAddress,
                        icon: const Icon(
                          Icons.email_outlined,
                          color: ColorApp.green,
                        ),
                        validator: (value) {
                          if (value == null || value == '') {
                            return context.l10n.empty_email;
                          } else if (!isValidEmail(value.trim())) {
                            return context.l10n.enter_email_valid;
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: ValueListenableBuilder(
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: PrimaryTextButton(
                  text: context.l10n.new_account,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: ColorApp.blue,
                    fontWeight: FontWeight.w500,
                  ),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RegisterPage.routeName,
                      (route) => false,
                    );
                  },
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: PrimaryTextButton(
                  text: context.l10n.forgot_password,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: ColorApp.blue,
                    fontWeight: FontWeight.w500,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteName.forgotPasswordPage);
                  },
                ),
              ),
              const SizedBox(height: 100),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteName.onboardingPage,
                      arguments: {NamedArguments.isRegister: true},
                      (route) => false,
                    ).then((_) => context.read<AccountBloc>().add(
                          OnInitialAccount(uid: state.data.user.uid),
                        ));
                    saveInfoUser(
                      state.data.token,
                      state.data.user.uid,
                      state.data.user.accountId,
                    );
                  } else if (state is LoginFailure) {
                    simpleBackDialog(
                      context: context,
                      message: context.l10n.invalid_email_or_pwd,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const CircularLoading();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: PrimaryButton(
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
                    ),
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
