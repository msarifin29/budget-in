import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:equatable/equatable.dart';

part 'monthly_report_detail_event.dart';
part 'monthly_report_detail_state.dart';

class MonthlyReportDetailBloc
    extends Bloc<MonthlyReportDetailEvent, MonthlyReportDetailState> {
  final MonthlyReportDetailUsecase usecase;

  MonthlyReportDetailBloc({
    required this.usecase,
  }) : super(MonthlyReportDetailInitial()) {
    on<InitialReportDetailEvent>((event, emit) async {
      emit(MonthlyReportDetailLoading());
      final result = await usecase(
        MonthlyReportDetailParam(
          month: event.month,
        ),
      );
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          log(message = l.message);
        }
        return MonthlyReportDetailFailure(message: message);
      }, (r) => MonthlyReportDetailSuccess(data: r.data)));
    });
  }
}
