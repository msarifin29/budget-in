import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'get_income_event.dart';
part 'get_income_state.dart';

class GetIncomeBloc extends Bloc<GetIncomeEvent, GetIncomeState> {
  final GetIncomesUsecase usecase;
  GetIncomeBloc({required this.usecase}) : super(GetIncomeInitial()) {
    on<InitialIncomeEvent>((event, emit) async {
      emit(GetIncomeLoading());
      final result = await usecase(
        GetIncomeParams(
          page: event.params.page,
          typeIncome: event.params.typeIncome,
          categoryId: event.params.categoryId,
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
        return GetIncomeFailure(message: message);
      }, (r) => GetIncomeSuccess(data: r.data)));
    });
  }
}
