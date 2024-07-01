import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:budget_in/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

String stringMonth(BuildContext context, int month) {
  switch (month) {
    case 1:
      return context.l10n.jan;
    case 2:
      return context.l10n.feb;
    case 3:
      return context.l10n.mar;
    case 4:
      return context.l10n.apr;
    case 5:
      return context.l10n.may;
    case 6:
      return context.l10n.jun;
    case 7:
      return context.l10n.jul;
    case 8:
      return context.l10n.aug;
    case 9:
      return context.l10n.sep;
    case 10:
      return context.l10n.oct;
    case 11:
      return context.l10n.nov;
    case 12:
      return context.l10n.dec;
    default:
      return '';
  }
}

String stringTotal(int income, int expense) {
  int total = income - expense;
  if (total == 0) {
    return '';
  }
  String newTotal = Helpers.currency(total);
  return newTotal;
}

class MonthlyReportPage extends StatefulWidget {
  static const routeName = RouteName.monthlyReportPage;
  const MonthlyReportPage({super.key});

  @override
  State<MonthlyReportPage> createState() => _MonthlyReportPageState();
}

class _MonthlyReportPageState extends State<MonthlyReportPage> {
  @override
  void initState() {
    monthlyEvent();
    super.initState();
  }

  void monthlyEvent() {
    context.read<GetMonthlyReportBloc>().add(
          MonthlyReportInitialEvent(uid: Helpers.getUid()),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight),
        child: NewAppBarWidget(
            title: TimeUtil().today(yyyy, DateTime.now()), leading: true),
      ),
      body: BlocBuilder<GetMonthlyReportBloc, GetMonthlyReportState>(
        builder: (context, state) {
          if (state is GetMonthlyReportLoading) {
            return const CircularLoading();
          } else if (state is GetMonthlyReportFailure) {
            return RefreshButton(onPressed: () {
              monthlyEvent();
            });
          } else if (state is GetMonthlyReportSuccess) {
            final data = state.data;
            return MonthlyReportSuccessWidget(data: data);
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class TextItem extends StatelessWidget {
  const TextItem({
    super.key,
    required this.title,
    required this.total,
  });

  final String title;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title:',
          style: GoogleFonts.publicSans(
              textStyle: context.textTheme.bodyMedium!,
              fontWeight: FontWeight.w500),
        ),
        Text(
          'Rp. $total',
          style: GoogleFonts.publicSans(
              textStyle: context.textTheme.bodyMedium!,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
