import 'package:budget_in/core/core.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ForgotPasswordpage extends StatefulWidget {
  static const routeName = RouteName.forgotPasswordPage;
  const ForgotPasswordpage({super.key});

  @override
  State<ForgotPasswordpage> createState() => _ForgotPasswordpageState();
}

class _ForgotPasswordpageState extends State<ForgotPasswordpage> {
  final globalKey = GlobalKey<FormState>();

  final emailControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
          title: context.l10n.forgot_password,
          leading: true,
        ),
      ),
      body: Form(
        key: globalKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              LottieBuilder.asset(
                LottieName.wallet,
                width: 100,
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
              PrimaryButton(
                text: context.l10n.submit,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
