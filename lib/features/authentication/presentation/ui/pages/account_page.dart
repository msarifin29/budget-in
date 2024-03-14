import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccountPage extends StatelessWidget {
  static const routeName = RouteName.accountPage;
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  return Column(
                    children: [
                      ListTile(
                        leading: SvgPicture.asset(
                          SvgName.profileCircle,
                          width: 40,
                          height: 40,
                          colorFilter: const ColorFilter.mode(
                            ColorApp.green,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          context.l10n.username,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: ColorApp.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          state.accountData.username,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: ColorApp.green,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: SvgPicture.asset(
                          SvgName.currencyCircle,
                          width: 40,
                          height: 40,
                          colorFilter: const ColorFilter.mode(
                            ColorApp.green,
                            BlendMode.srcIn,
                          ),
                        ),
                        title: Text(
                          context.l10n.currency,
                          style: context.textTheme.bodyMedium!.copyWith(
                            color: ColorApp.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: Text(
                          state.accountData.currency,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: ColorApp.green,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            ListTile(
              leading: SvgPicture.asset(
                SvgName.privacy,
                width: 40,
                height: 40,
                colorFilter: const ColorFilter.mode(
                  ColorApp.green,
                  BlendMode.srcIn,
                ),
              ),
              title: Text(
                context.l10n.privacy_and_policy,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: ColorApp.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ListTile(
              leading: SvgPicture.asset(
                SvgName.contactSupport,
                width: 40,
                height: 40,
                colorFilter: const ColorFilter.mode(
                  ColorApp.green,
                  BlendMode.srcIn,
                ),
              ),
              title: Text(
                context.l10n.contact_support,
                style: context.textTheme.bodyMedium!.copyWith(
                  color: ColorApp.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.41,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                text: context.l10n.sigout,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
