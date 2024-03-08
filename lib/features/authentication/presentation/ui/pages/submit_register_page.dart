import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/expenses/presentation/ui/expenses_ui.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubmitRegisterPage extends StatefulWidget {
  const SubmitRegisterPage({super.key});
  static const routeName = RouteName.submitRegisterPage;

  @override
  State<SubmitRegisterPage> createState() => _SubmitRegisterPageState();
}

class _SubmitRegisterPageState extends State<SubmitRegisterPage> {
  final globalKey = GlobalKey<FormState>();

  final balanceControl = TextEditingController();
  final cashControl = TextEditingController();

  @override
  void dispose() {
    balanceControl.dispose();
    cashControl.dispose();
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
                      if (value == null || value == '') {
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
                      if (value == null || value == '') {
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
            PrimaryButton(
              text: Strings.submit,
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
