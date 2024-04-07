import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:equatable/equatable.dart';

part 'get_max_budget_event.dart';
part 'get_max_budget_state.dart';

class GetMaxBudgetBloc extends Bloc<GetMaxBudgetEvent, GetMaxBudgetState> {
  final GetMaxBudgetUsecase usecase;
  GetMaxBudgetBloc({required this.usecase}) : super(GetMaxBudgetInitial()) {
    on<InitialData>((event, emit) async {
      emit(GetMaxBudgetLoading());
      final result = await usecase(
        GetMaxBudgetparam(
          accountId: event.accountId,
          uid: event.uid,
        ),
      );
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Failure';
        } else if (l is ParsingFailure) {
          log(message = l.message);
        }
        return GetMaxBudgetFailure(message: message);
      }, (r) => GetMaxBudgetSuccess(response: r)));
    });
  }
}
