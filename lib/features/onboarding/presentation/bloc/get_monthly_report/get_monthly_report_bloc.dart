import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:equatable/equatable.dart';

part 'get_monthly_report_event.dart';
part 'get_monthly_report_state.dart';

class GetMonthlyReportBloc
    extends Bloc<GetMonthlyReportEvent, GetMonthlyReportState> {
  final GetOnboardingUsecase usecase;
  GetMonthlyReportBloc({required this.usecase})
      : super(GetMonthlyReportInitial()) {
    on<MonthlyReportInitialEvent>((event, emit) async {
      emit(GetMonthlyReportLoading());
      final result = await usecase(event.uid);
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          log(message = l.message);
        }
        return GetMonthlyReportFailure(message: message);
      }, (r) => GetMonthlyReportSuccess(data: r.data)));
    });
  }
}
