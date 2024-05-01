import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:budget_in/injection.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  void dispose() {
    emailControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(
        usecase: sl<ForgotPasswordUsecase>(),
      ),
      child: Scaffold(
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
                const CircleAvatar(
                  radius: 50,
                  child: Icon(
                    Icons.mark_email_read_outlined,
                    size: 65,
                    color: ColorApp.green,
                  ),
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
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 20),
                BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordFailure) {
                      if (state.message.contains('email')) {
                        context.scaffoldMessenger.showSnackBar(
                          floatingSnackBar(
                            context,
                            context.l10n.failed_forgot_password,
                          ),
                        );
                      } else {
                        context.scaffoldMessenger.showSnackBar(
                          floatingSnackBar(
                            context,
                            context.l10n.try_again_later,
                          ),
                        );
                      }
                    }
                    if (state is ForgotPasswordSuccess) {
                      Navigator.pop(context);
                      context.scaffoldMessenger.showSnackBar(
                        floatingSnackBar(
                          context,
                          context.l10n.success_forgot_password,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ForgotPasswordLoading) {
                      return const CircularLoading();
                    }
                    return PrimaryButton(
                      text: context.l10n.submit,
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          context.read<ForgotPasswordBloc>().add(
                                OnReset(
                                  email: emailControl.text.trim(),
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
      ),
    );
  }
}
