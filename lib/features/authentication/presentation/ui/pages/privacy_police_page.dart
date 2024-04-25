import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/data/authentication_data.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PrivacyPolicePage extends StatefulWidget {
  static const routeName = RouteName.privacyPolicePage;
  const PrivacyPolicePage({super.key});

  @override
  State<PrivacyPolicePage> createState() => _PrivacyPolicePageState();
}

class _PrivacyPolicePageState extends State<PrivacyPolicePage> {
  String localeCode = '';
  @override
  void initState() {
    super.initState();
    localeCode = PlatformDispatcher.instance.locale.languageCode;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
          title: context.l10n.privacy_and_policy,
          leading: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Html(
          data: localeCode == 'id' ? privacyIn : privacyEn,
        ),
      ),
    );
  }
}
