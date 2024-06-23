import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:equatable/equatable.dart';

part 'monthly_report_category_event.dart';
part 'monthly_report_category_state.dart';

class MonthlyReportCategoryBloc
    extends Bloc<MonthlyReportCategoryEvent, MonthlyReportCategoryState> {
  final MonthlyReportCategoryUsecase usecase;
  MonthlyReportCategoryBloc({required this.usecase})
      : super(MonthlyReportCategoryInitial()) {
    on<InitialCategory>(initialCategory);
  }

  FutureOr<void> initialCategory(
      InitialCategory event, Emitter<MonthlyReportCategoryState> emit) async {
    emit(MonthlyReportCategoryLoading());
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
      return MonthlyReportCategoryFailure(message: message);
    }, (r) => MonthlyReportCategorySuccess(data: r.data)));
  }
}
