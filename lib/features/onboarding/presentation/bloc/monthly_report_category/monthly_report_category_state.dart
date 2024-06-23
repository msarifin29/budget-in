part of 'monthly_report_category_bloc.dart';

sealed class MonthlyReportCategoryState extends Equatable {
  const MonthlyReportCategoryState();

  @override
  List<Object> get props => [];
}

final class MonthlyReportCategoryInitial extends MonthlyReportCategoryState {}

final class MonthlyReportCategoryLoading extends MonthlyReportCategoryState {}

final class MonthlyReportCategorySuccess extends MonthlyReportCategoryState {
  final MonthlyCategoryData data;
  const MonthlyReportCategorySuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class MonthlyReportCategoryFailure extends MonthlyReportCategoryState {
  final String message;
  const MonthlyReportCategoryFailure({required this.message});

  @override
  List<Object> get props => [message];
}
