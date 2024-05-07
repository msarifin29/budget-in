// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:equatable/equatable.dart';

import 'package:budget_in/features/incomes/incomes.dart';
import 'package:flutter/rendering.dart';

part 'create_income_event.dart';
part 'create_income_state.dart';

class CreateIncomeBloc extends Bloc<CreateIncomeEvent, CreateIncomeState> {
  final CreateIncomeUsecase usecase;
  CreateIncomeBloc({required this.usecase}) : super(CreateIncomeInitial()) {
    on<InitialCreateEvent>((event, emit) async {
      emit(CreateIncomeLoading());
      final result = await usecase(
        CreateIncomeParams(
          uid: event.uid,
          categoryIncome: event.categoryIcome,
          categoryId: event.categoryId,
          typeIncome: event.typeIcome,
          total: event.total,
          accountId: event.accountId,
          createdAt: event.createdAt,
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
        return CreateIncomeFailed(message: message);
      }, (r) => CreateIncomeSuccess(data: r.data)));
    });
  }
}
