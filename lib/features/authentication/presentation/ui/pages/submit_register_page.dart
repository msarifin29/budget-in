// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:budget_in/features/authentication/presentation/bloc/register/register_bloc.dart';
import 'package:budget_in/injection.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  final isChecked = ValueNotifier(false);

  String localeCode = '';
  @override
  void initState() {
    super.initState();
    localeCode = PlatformDispatcher.instance.locale.languageCode;
    context.read<PrivacyBloc>().add(InitialPrivacy(localeCode));
  }

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
              const SizedBox(height: 20),
              Form(
                key: globalKey,
                child: Column(
                  children: [
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
              const SizedBox(height: 50),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ValueListenableBuilder(
                      valueListenable: isChecked,
                      builder: (context, v, _) {
                        return Checkbox(
                          checkColor: Colors.white,
                          value: isChecked.value,
                          onChanged: (bool? value) {
                            isChecked.value = !isChecked.value;
                          },
                        );
                      }),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        PrivacyPolicePage.routeName,
                      );
                    },
                    child: Text(context.l10n.privacy_and_policy),
                  ),
                ],
              ),
              const SizedBox(height: 40),
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
                    simpleBackDialog(
                      context: context,
                      message: context.l10n.failed_create_account,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is RegisterLoading) {
                    return const CircularLoading();
                  }
                  return PrimaryButton(
                    text: context.l10n.submit,
                    onPressed: () {
                      if (!isChecked.value) return;
                      if (globalKey.currentState!.validate()) {
                        context.read<RegisterBloc>().add(
                              OnUserRegister(
                                  username: widget.username,
                                  email: widget.email,
                                  password: widget.password,
                                  accountName: widget.username,
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

class InfoBankWidget extends StatelessWidget {
  const InfoBankWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.l10n.bank_name,
          style: context.textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        // CustomPopup(
        //   barrierColor: Colors.green.withOpacity(0.0),
        //   backgroundColor: ColorApp.grey,
        //   content: Text(
        //     context.l10n.bank_info,
        //     style: const TextStyle(
        //       color: Colors.black,
        //       fontSize: 12,
        //     ),
        //   ),
        //   child: const Icon(
        //     Icons.error_outline_outlined,
        //     color: ColorApp.green,
        //     size: 18,
        //   ),
        // ),
      ],
    );
  }
}
