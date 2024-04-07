// ignore_for_file: public_member_api_docs, sort_constructors_first, inference_failure_on_function_invocation, lines_longer_than_80_chars
import 'package:budget_in/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/l10n/l10n.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = RouteName.profilePage;

  const ProfilePage({super.key, required this.data});
  final AccountData data;
  @override
  Widget build(BuildContext context) {
    final spm = sl<SharedPreferencesManager>();
    final fss = sl<SecureStorageManager>();
    void clearLocalData() async {
      await fss.deleteToken();
      await spm.clearKey(SharedPreferencesManager.keyUid);
      await spm.clearKey(SharedPreferencesManager.keyAccountId);
    }

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
          title: 'Profile',
          leading: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            DetailAccountwidget(
              image: SvgName.profileCircle,
              title: context.l10n.username,
              subTitle: data.username,
            ),
            DetailAccountwidget(
              image: SvgName.email,
              title: context.l10n.email,
              subTitle: data.email,
            ),
            DetailAccountwidget(
              image: SvgName.currencyCircle,
              title: context.l10n.currency,
              subTitle: data.currency,
            ),
            DetailAccountwidget(
              image: SvgName.delete,
              title: context.l10n.delete_account,
              subTitle: '',
              onTap: () {
                selectedDialog(
                  context,
                  onContinue: () {
                    Navigator.pushNamedAndRemoveUntil(
                            context, RouteName.loginPage, (route) => false)
                        .then((_) => clearLocalData);
                  },
                  title: context.l10n.confir_delete_account,
                  image: SvgName.delete,
                  color: ColorApp.red,
                );
              },
            ),

            // Align(
            //   child: InkWell(
            //     borderRadius: BorderRadius.circular(120),
            //     onTap: () {},
            //     child: Container(
            //       height: valueBox,
            //       width: valueBox,
            //       decoration: BoxDecoration(
            //         border: Border.all(width: 5, color: ColorApp.grey30),
            //         shape: BoxShape.circle,
            //       ),
            //       child: Lottie.asset(
            //         LottieName.imageLoading,
            //         width: 120,
            //         height: 120,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class DetailAccountwidget extends StatelessWidget {
  const DetailAccountwidget({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.onTap,
  });

  final String image;
  final String title;
  final String subTitle;
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
      subtitle: Text(
        subTitle,
        style: context.textTheme.bodySmall!.copyWith(
          color: ColorApp.green,
        ),
      ),
    );
  }
}
