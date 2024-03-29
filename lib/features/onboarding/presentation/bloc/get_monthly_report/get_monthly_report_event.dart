part of 'get_monthly_report_bloc.dart';

sealed class GetMonthlyReportEvent extends Equatable {
  const GetMonthlyReportEvent();

  @override
  List<Object> get props => [];
}

final class MonthlyReportInitialEvent extends GetMonthlyReportEvent {
  const MonthlyReportInitialEvent({required this.uid});
  final String uid;
  @override
  List<Object> get props => [uid];
}
