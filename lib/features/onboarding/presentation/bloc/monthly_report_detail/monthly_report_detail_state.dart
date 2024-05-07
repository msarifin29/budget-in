part of 'monthly_report_detail_bloc.dart';

sealed class MonthlyReportDetailState extends Equatable {
  const MonthlyReportDetailState();

  @override
  List<Object> get props => [];
}

final class MonthlyReportDetailInitial extends MonthlyReportDetailState {}

final class MonthlyReportDetailLoading extends MonthlyReportDetailState {}

final class MonthlyReportDetailSuccess extends MonthlyReportDetailState {
  final MonthlyReportDetailData data;

  const MonthlyReportDetailSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class MonthlyReportDetailFailure extends MonthlyReportDetailState {
  final String message;

  const MonthlyReportDetailFailure({required this.message});
  @override
  List<Object> get props => [message];
}
