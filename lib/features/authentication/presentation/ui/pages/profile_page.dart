// ignore_for_file: public_member_api_docs, sort_constructors_first, inference_failure_on_function_invocation, lines_longer_than_80_chars
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/presentation/ui/authentication_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = RouteName.profilePage;

  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    const valueBox = 150.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (context) => const DialogProfileWidget(),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              child: SvgPicture.asset(SvgName.setting),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Align(
              child: InkWell(
                borderRadius: BorderRadius.circular(120),
                onTap: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) => const DialogImageProfileWidget(),
                  );
                },
                child: Container(
                  height: valueBox,
                  width: valueBox,
                  decoration: BoxDecoration(
                    border: Border.all(width: 5, color: ColorApp.grey30),
                    shape: BoxShape.circle,
                  ),
                  child: Lottie.asset(
                    LottieName.imageLoading,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            const ItemProfileWidget(
              k: 'Name',
              v: 'User Name',
            ),
            const ItemProfileWidget(
              k: 'Email',
              v: 'user@mail.com',
            ),
            const ItemProfileWidget(
              k: Strings.domicile,
              v: 'Denpasar',
            ),
            const ItemProfileWidget(
              k: Strings.income,
              v: 'Rp. 2.000.000',
            ),
            const ItemProfileWidget(
              k: Strings.occupation,
              v: 'Chef',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 20,
        ),
        child: IconTextWidget(
          onTap: () {},
          image: SvgName.signout,
          title: Strings.signout,
        ),
      ),
    );
  }
}
