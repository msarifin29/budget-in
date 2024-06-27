import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:equatable/equatable.dart';

part 'monthly_report_dashboard_event.dart';
part 'monthly_report_dashboard_state.dart';

class MonthlyReportDashboardBloc
    extends Bloc<MonthlyReportDashboardEvent, MonthlyReportDashboardState> {
  final MonthlyReportCategoryUsecase usecase;
  MonthlyReportDashboardBloc({required this.usecase})
      : super(MonthlyReportDashboardInitial()) {
    on<InitialDashboard>(initialCategory);
  }

  FutureOr<void> initialCategory(
      InitialDashboard event, Emitter<MonthlyReportDashboardState> emit) async {
    emit(MonthlyReportDashboardLoading());
    final result = await usecase(MonthlyReportDetailParam(month: event.month));
    emit(result.fold((l) {
      var message = '';
      if (l is ServerFailure) {
        message = l.failure.message ?? '';
      } else if (l is ConnectionFailure) {
        message = 'Connection Faiure';
      } else if (l is ParsingFailure) {
        log(message = l.message);
      }
      return MonthlyReportDashboardFailure(message: message);
    }, (r) => MonthlyReportDashboardSuccess(data: r.data)));
  }
}
