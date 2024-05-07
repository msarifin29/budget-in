import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'get_histories_credit_event.dart';
part 'get_histories_credit_state.dart';

class GetHistoriesCreditBloc
    extends Bloc<GetHistoriesCreditEvent, GetHistoriesCreditState> {
  final GetHistoriesUsecase usecase;
  GetHistoriesCreditBloc({required this.usecase})
      : super(GetHistoriesCreditInitial()) {
    on<InitialHistoriesEvent>((event, emit) async {
      emit(GetHistoriesCreditLoading());
      final result = await usecase(
        GetHistorisCreditParams(
          page: event.params.page,
          totalPage: event.params.totalPage,
          creditId: event.params.creditId,
        ),
      );
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          debugPrint(message = l.message);
        }
        return GetHistoriesCreditFailure(message: message);
      }, (r) => GetHistoriesCreditSuccess(data: r.data)));
    });
  }
}
