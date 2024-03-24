import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:equatable/equatable.dart';

part 'get_credits_event.dart';
part 'get_credits_state.dart';

class GetCreditsBloc extends Bloc<GetCreditsEvent, GetCreditsState> {
  final GetCreditUsecase usecase;
  GetCreditsBloc({required this.usecase}) : super(GetCreditsInitial()) {
    on<InitialCreditEvent>((event, emit) async {
      emit(GetCreditsLoading());
      final result = await usecase(
        GetCreditParams(
            page: event.params.page, totalPage: event.params.totalPage),
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
        return GetCreditsFailure(message: message);
      }, (r) => GetCreditsSuccess(response: r)));
    });
  }
}
