// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'monthly_report_dashboard_bloc.dart';

sealed class MonthlyReportDashboardEvent extends Equatable {
  const MonthlyReportDashboardEvent();

  @override
  List<Object> get props => [];
}

class InitialDashboard extends MonthlyReportDashboardEvent {
  const InitialDashboard({required this.month});
  final String month;

  @override
  List<Object> get props => [month];
  @override
  String toString() {
    return 'InitialCategory{month:$month}';
  }
}
