// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:budget_in/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:budget_in/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/l10n/l10n.dart';

class SubmitRegisterPage extends StatefulWidget {
  const SubmitRegisterPage({
    super.key,
    required this.username,
    required this.email,
    required this.password,
  });
  static const routeName = RouteName.submitRegisterPage;
  final String username;
  final String email;
  final String password;

  @override
  State<SubmitRegisterPage> createState() => _SubmitRegisterPageState();
}

class _SubmitRegisterPageState extends State<SubmitRegisterPage> {
  final globalKey = GlobalKey<FormState>();

  final balanceControl = TextEditingController();
  final cashControl = TextEditingController();
  final ssm = sl<SecureStorageManager>();
  final spm = sl<SharedPreferencesManager>();

  @override
  void dispose() {
    balanceControl.dispose();
    cashControl.dispose();
    super.dispose();
  }

  void saveInfoUser(String token, String uid) async {
    await ssm.saveToken(token);
    await spm.putString(SharedPreferencesManager.keyUid, uid);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(sl<RegisterUsecase>()),
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
                    const SizedBox(height: 20),
                    FormWidget(
                      title: context.l10n.balance,
                      hint: '0',
                      hintStyle: context.textTheme.bodyLarge!.copyWith(
                        color: ColorApp.green,
                        fontWeight: FontWeight.w700,
                      ),
                      controller: balanceControl,
                      keyboardType: TextInputType.number,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(SvgName.bank),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Rp.',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: ColorApp.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value == '' ||
                            int.parse(value) < 100000) {
                          return context.l10n.empty_balance;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    FormWidget(
                      title: context.l10n.cash,
                      hint: '0',
                      hintStyle: context.textTheme.bodyLarge!.copyWith(
                        color: ColorApp.green,
                        fontWeight: FontWeight.w700,
                      ),
                      controller: cashControl,
                      keyboardType: TextInputType.number,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(SvgName.wallet),
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Rp.',
                          style: context.textTheme.bodyLarge!.copyWith(
                            color: ColorApp.green,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value == '' ||
                            int.parse(value) < 0000) {
                          return context.l10n.empty_cash;
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(context.l10n.have_account),
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
              const SizedBox(height: 100),
              BlocConsumer<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  log('register => $state');
                  if (state is RegisterSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteName.mainPage,
                      arguments: {NamedArguments.currentIndex: 0},
                      (route) => false,
                    ).then((_) => context.read<AccountBloc>().add(
                          OnInitialAccount(uid: state.data.user.uid),
                        ));
                    saveInfoUser(state.data.token, state.data.user.uid);
                  } else if (state is RegisterFailure) {
                    simpleDialog(context: context, title: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const CircularLoading();
                  }
                  return PrimaryButton(
                    text: Strings.submit,
                    onPressed: () {
                      if (globalKey.currentState!.validate()) {
                        context.read<RegisterBloc>().add(
                              OnUserRegister(
                                  username: widget.username,
                                  email: widget.email,
                                  password: widget.password,
                                  balance:
                                      double.parse(balanceControl.text.trim()),
                                  cash: double.parse(cashControl.text.trim())),
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
