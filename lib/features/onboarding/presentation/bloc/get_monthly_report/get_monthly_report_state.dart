part of 'get_monthly_report_bloc.dart';

sealed class GetMonthlyReportState extends Equatable {
  const GetMonthlyReportState();

  @override
  List<Object> get props => [];
}

final class GetMonthlyReportInitial extends GetMonthlyReportState {}

final class GetMonthlyReportLoading extends GetMonthlyReportState {}

final class GetMonthlyReportSuccess extends GetMonthlyReportState {
  final List<MonthlyReportData> data;

  const GetMonthlyReportSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class GetMonthlyReportFailure extends GetMonthlyReportState {
  final String message;

  const GetMonthlyReportFailure({required this.message});
  @override
  List<Object> get props => [message];
}
