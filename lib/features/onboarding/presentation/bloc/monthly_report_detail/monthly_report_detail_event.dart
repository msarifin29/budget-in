part of 'monthly_report_detail_bloc.dart';

sealed class MonthlyReportDetailEvent extends Equatable {
  const MonthlyReportDetailEvent();

  @override
  List<Object> get props => [];
}

final class InitialReportDetailEvent extends MonthlyReportDetailEvent {
  const InitialReportDetailEvent({required this.month});
  final String month;
  @override
  List<Object> get props => [month];
}
