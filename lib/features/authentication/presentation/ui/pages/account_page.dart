import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/injection.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountPage extends StatelessWidget {
  static const routeName = RouteName.accountPage;
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final spm = sl<SharedPreferencesManager>();
    final fss = sl<SecureStorageManager>();
    Future<void> clearLocalData() async {
      await fss.deleteToken();
      await spm.clearKey(SharedPreferencesManager.keyUid);
      await spm.clearKey(SharedPreferencesManager.keyAccountId);
    }

    Future<T?> dialogDeleteAccount<T>() {
      return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return BlocProvider(
              create: (context) =>
                  DeleteAccountBloc(usecase: sl<DeleteAccountUsecase>()),
              child: AlertDialog(
                title: Column(
                  children: [
                    const SizedBox(height: 20),
                    SvgPicture.asset(
                      SvgName.delete,
                      colorFilter:
                          const ColorFilter.mode(ColorApp.red, BlendMode.srcIn),
                      width: 65,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      context.l10n.confir_delete_account,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: (Theme.of(context).brightness ==
                                    Brightness.light
                                ? ColorApp.green
                                : Colors.grey),
                          ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
                actions: <Widget>[
                  BlocConsumer<DeleteAccountBloc, DeleteAccountState>(
                    listener: (context, state) {
                      if (state is DeleteAccountFailure) {
                        Navigator.pop(context);
                        context.scaffoldMessenger.showSnackBar(
                          floatingSnackBar(
                            context,
                            context.l10n.try_again_later,
                          ),
                        );
                      } else if (state is DeleteAccountSuccess) {
                        Navigator.pushNamedAndRemoveUntil(
                                context, LoginPage.routeName, (route) => false)
                            .then((_) => clearLocalData());
                      }
                    },
                    builder: (context, state) {
                      if (state is DeleteAccountLoading) {
                        return const CircularLoading();
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          PrimaryButton(
                            text: context.l10n.no,
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            minSize: const Size(80, 45),
                            backgroundColor: ColorApp.rootBeer,
                          ),
                          PrimaryButton(
                            onPressed: () {
                              context.read<DeleteAccountBloc>().add(
                                    OnDeleted(),
                                  );
                            },
                            text: context.l10n.yes,
                            minSize: const Size(80, 45),
                            backgroundColor: ColorApp.red.withOpacity(0.7),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
          title: context.l10n.account,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountSuccess) {
                  return DetailAccountwidget(
                    image: SvgName.profileCircle,
                    title: context.l10n.account,
                    subTitle: state.accountData.username,
                    onTap: () {
                      Navigator.pushNamed(context, ProfilePage.routeName,
                          arguments: {
                            NamedArguments.accountData: state.accountData,
                          });
                    },
                  );
                }
                return const SizedBox();
              },
            ),
            // DetailAccountOnlyTitlewidget(
            //   image: SvgName.privacy,
            //   title: context.l10n.privacy_and_policy,
            //   onTap: () {
            //     Navigator.pushNamed(context, PrivacyPolicePage.routeName);
            //   },
            // ),
            // DetailAccountOnlyTitlewidget(
            //     image: SvgName.contactSupport,
            //     title: context.l10n.contact_support,),
            DetailAccountOnlyTitlewidget(
              image: SvgName.password,
              title: context.l10n.reset_password,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ResetPasswordPage.routeName,
                );
              },
            ),
            DetailAccountOnlyTitlewidget(
              image: SvgName.delete,
              title: context.l10n.delete_account,
              onTap: () => dialogDeleteAccount(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: PrimaryButton(
          text: context.l10n.sigout,
          onPressed: () {
            selectedDialog(
              context,
              onContinue: () {
                clearLocalData().then((_) => Navigator.pushNamedAndRemoveUntil(
                    context, RouteName.loginPage, (route) => false));
              },
              title: context.l10n.confirm_sign_out,
              image: SvgName.signout,
              color: ColorApp.green,
            );
          },
        ),
      ),
    );
  }
}

class DetailAccountOnlyTitlewidget extends StatelessWidget {
  const DetailAccountOnlyTitlewidget({
    super.key,
    required this.image,
    required this.title,
    this.onTap,
  });

  final String image;
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(
        image,
        width: 30,
        height: 30,
        colorFilter: const ColorFilter.mode(
          ColorApp.green,
          BlendMode.srcIn,
        ),
      ),
      title: Text(
        title,
        style: context.textTheme.bodyMedium!.copyWith(
          color: ColorApp.green,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
