import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/onboarding/onboarding.dart';
import 'package:equatable/equatable.dart';

part 'update_max_budget_event.dart';
part 'update_max_budget_state.dart';

class UpdateMaxBudgetBloc
    extends Bloc<UpdateMaxBudgetEvent, UpdateMaxBudgetState> {
  final UpdateMaxBudgetUsecase usecase;
  UpdateMaxBudgetBloc({required this.usecase})
      : super(UpdateMaxBudgetInitial()) {
    on<OnUpdated>((event, emit) async {
      emit(UpdateMaxBudgetLoading());
      final result =
          await usecase(UpdateMaxBudgetparam(maxBudget: event.param.maxBudget));
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          log(message = l.message);
        }
        return UpdateMaxBudgetFailure(message: message);
      }, (r) => UpdateMaxBudgetSuccess(response: r)));
    });
  }
}
