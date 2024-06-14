// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bank_event.dart';
part 'bank_state.dart';

class BankBloc extends Bloc<BankEvent, BankState> {
  final GetBank getBank;
  BankBloc({required this.getBank}) : super(const BankState(bank: [])) {
    on<OnInitial>(initial);
  }

  FutureOr<void> initial(OnInitial event, Emitter<BankState> emit) async {
    final result = await getBank(NoParams());
    result.fold(
      (l) => emit(const BankState(bank: [])),
      (r) => emit(BankState(bank: r)),
    );
  }
}
