// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:budget_in/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:budget_in/injection.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
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
  final nameControl = TextEditingController();
  final ssm = sl<SecureStorageManager>();
  final spm = sl<SharedPreferencesManager>();

  @override
  void dispose() {
    balanceControl.dispose();
    cashControl.dispose();
    nameControl.dispose();
    super.dispose();
  }

  void saveInfoUser(String token, String uid, String accountId) async {
    await ssm.saveToken(token);
    await spm.putString(SharedPreferencesManager.keyUid, uid);
    await spm.putString(SharedPreferencesManager.keyAccountId, accountId);
  }

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    symbol: '',
    decimalDigits: 0,
  );
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterBloc>(),
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
                      title: context.l10n.bank_name,
                      hint: '',
                      controller: nameControl,
                      isShowPopUp: true,
                      msg: context.l10n.bank_info,
                      icon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(SvgName.bank),
                      ),
                      validator: (value) {
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    FormWidget(
                      title: context.l10n.balance,
                      hint: '0',
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: ColorApp.green,
                        fontWeight: FontWeight.w700,
                      ),
                      hintStyle: context.textTheme.bodyLarge!.copyWith(
                        color: ColorApp.green,
                        fontWeight: FontWeight.w700,
                      ),
                      controller: balanceControl,
                      keyboardType: TextInputType.number,
                      isShowPopUp: true,
                      msg: context.l10n.balance_info,
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
                            double.parse(
                                    value.replaceAll(RegExp(r'[^0-9]'), '')) <
                                100000) {
                          return context.l10n.empty_balance;
                        }
                        return null;
                      },
                      inputFormatters: [formatter],
                    ),
                    const SizedBox(height: 20),
                    FormWidget(
                      title: context.l10n.cash,
                      hint: '0',
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: ColorApp.green,
                        fontWeight: FontWeight.w700,
                      ),
                      hintStyle: context.textTheme.bodyLarge!.copyWith(
                        color: ColorApp.green,
                        fontWeight: FontWeight.w700,
                      ),
                      controller: cashControl,
                      keyboardType: TextInputType.number,
                      isShowPopUp: true,
                      msg: context.l10n.cash_info,
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
                            double.parse(
                                    value.replaceAll(RegExp(r'[^0-9]'), '')) <
                                0000) {
                          return context.l10n.empty_cash;
                        }
                        return null;
                      },
                      inputFormatters: [formatter],
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
                  debugPrint('register => $state');
                  if (state is RegisterSuccess) {
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
                  } else if (state is RegisterFailure) {
                    simpleDialog(
                        context: context,
                        title: context.l10n.failed_create_account);
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
                                  balance: balanceControl.text.trim(),
                                  cash: cashControl.text.trim()),
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
