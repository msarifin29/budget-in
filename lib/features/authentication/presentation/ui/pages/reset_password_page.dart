import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/injection.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordPage extends StatefulWidget {
  static const routeName = RouteName.resetPasswordPage;
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final globalKey = GlobalKey<FormState>();

  final oldPassControl = TextEditingController();
  final newPassControl = TextEditingController();
  final confirmPassControl = TextEditingController();
  final obscureText = ValueNotifier(true);

  @override
  void dispose() {
    oldPassControl.dispose();
    newPassControl.dispose();
    confirmPassControl.dispose();
    super.dispose();
  }

  final spm = sl<SharedPreferencesManager>();
  final fss = sl<SecureStorageManager>();
  Future<void> clearLocalData() async {
    await fss.deleteToken();
    await spm.clearKey(SharedPreferencesManager.keyUid);
    await spm.clearKey(SharedPreferencesManager.keyAccountId);
  }

  Future<T?> dialogResetPassword<T>() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return PopScope(
            canPop: false,
            child: AlertDialog(
              title: Column(
                children: [
                  const SizedBox(height: 20),
                  SvgPicture.asset(
                    SvgName.password,
                    colorFilter:
                        const ColorFilter.mode(ColorApp.red, BlendMode.srcIn),
                    width: 65,
                  ),
                  Text(
                    context.l10n.success_reset_pwd,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color:
                              (Theme.of(context).brightness == Brightness.light
                                  ? ColorApp.green
                                  : Colors.grey),
                        ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              actions: <Widget>[
                PrimaryButton(
                  onPressed: () {
                    clearLocalData().then(
                      (_) => Navigator.pushNamedAndRemoveUntil(
                          context, LoginPage.routeName, (route) => false),
                    );
                  },
                  text: context.l10n.yes,
                  minSize: const Size(150, 45),
                  backgroundColor: ColorApp.green,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordBloc(
        usecase: sl<ResetPasswordUsecase>(),
      ),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: NewAppBarWidget(
            title: context.l10n.reset_password,
            leading: true,
          ),
        ),
        body: Form(
          key: globalKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).cardColor,
                  child: const Icon(
                    Icons.mark_email_read_outlined,
                    size: 65,
                    color: ColorApp.green,
                  ),
                ),
                const SizedBox(height: 20),
                ValueListenableBuilder(
                    valueListenable: obscureText,
                    builder: (context, newValue, _) {
                      return FormWidget(
                        title: context.l10n.old_password,
                        hint: '',
                        controller: oldPassControl,
                        obscureText: obscureText.value,
                        icon: IconButton(
                          onPressed: () {
                            obscureText.value = !obscureText.value;
                          },
                          icon: Icon(obscureText.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value == '') {
                            return context.l10n.empty_password;
                          } else if (value.length < 6) {
                            return context.l10n.password_to_short;
                          }
                          return null;
                        },
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                        },
                      );
                    }),
                const SizedBox(height: 10),
                FormWidget(
                  title: context.l10n.new_password,
                  hint: '',
                  controller: newPassControl,
                  validator: (value) {
                    if (value == null || value == '') {
                      return context.l10n.empty_password;
                    } else if (value.length < 6) {
                      return context.l10n.password_to_short;
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 10),
                FormWidget(
                  title: context.l10n.confirm_password,
                  hint: '',
                  controller: confirmPassControl,
                  validator: (value) {
                    if (value == null || value == '') {
                      return context.l10n.empty_password;
                    } else if (value.length < 6) {
                      return context.l10n.password_to_short;
                    } else if (newPassControl.text.isNotEmpty &&
                        newPassControl.text.trim() != value) {
                      return context.l10n.invalid_password;
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
                const SizedBox(height: 75),
                BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
                  listener: (context, state) {
                    if (state is ResetPasswordFailure) {
                      context.scaffoldMessenger.showSnackBar(
                        floatingSnackBar(
                            context, context.l10n.failed_reset_pwd),
                      );
                    }
                    if (state is ResetPasswordSuccess) {
                      dialogResetPassword();
                    }
                  },
                  builder: (context, state) {
                    if (state is ResetPasswordLoading) {
                      return const CircularLoading();
                    }
                    return PrimaryButton(
                      text: context.l10n.submit,
                      onPressed: () {
                        if (globalKey.currentState!.validate()) {
                          context.read<ResetPasswordBloc>().add(
                                InitialReset(
                                  oldPassword: oldPassControl.text.trim(),
                                  newPassword: newPassControl.text.trim(),
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
