// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'monthly_report_category_bloc.dart';

sealed class MonthlyReportCategoryEvent extends Equatable {
  const MonthlyReportCategoryEvent();

  @override
  List<Object> get props => [];
}

class InitialCategory extends MonthlyReportCategoryEvent {
  const InitialCategory({required this.month});
  final String month;

  @override
  List<Object> get props => [month];
  @override
  String toString() {
    return 'InitialCategory{month:$month}';
  }
}
