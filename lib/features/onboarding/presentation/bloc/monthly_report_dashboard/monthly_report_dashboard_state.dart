part of 'monthly_report_dashboard_bloc.dart';

sealed class MonthlyReportDashboardState extends Equatable {
  const MonthlyReportDashboardState();

  @override
  List<Object> get props => [];
}

final class MonthlyReportDashboardInitial extends MonthlyReportDashboardState {}

final class MonthlyReportDashboardLoading extends MonthlyReportDashboardState {}

final class MonthlyReportDashboardSuccess extends MonthlyReportDashboardState {
  final MonthlyCategoryData data;
  const MonthlyReportDashboardSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class MonthlyReportDashboardFailure extends MonthlyReportDashboardState {
  final String message;
  const MonthlyReportDashboardFailure({required this.message});

  @override
  List<Object> get props => [message];
}
