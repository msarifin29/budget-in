import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/incomes/incomes.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cash_withdrawal_event.dart';
part 'cash_withdrawal_state.dart';

class CashWithdrawalBloc
    extends Bloc<CashWithdrawalEvent, CashWithdrawalState> {
  final CashWithdrawalUsecase usecase;
  CashWithdrawalBloc({required this.usecase}) : super(CashWithdrawalInitial()) {
    on<Withdraw>((event, emit) async {
      emit(CashWithdrawalLoading());
      final result = await usecase(CashWithdrawalParam(total: event.total));
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          debugPrint(message = l.message);
        }
        return CashWithdrawalFailure(message: message);
      }, (r) => CashWithdrawalSuccess()));
    });
  }
}
