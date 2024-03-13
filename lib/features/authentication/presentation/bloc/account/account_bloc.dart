// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:equatable/equatable.dart';

import 'package:budget_in/features/authentication/authentication.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountUsecase accountUsecase;
  AccountBloc({required this.accountUsecase}) : super(AccountInitial()) {
    on<OnInitialAccount>((event, emit) async {
      emit(AccountLoading());
      final result = await accountUsecase(event.uid);
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          log(message = l.message);
        }
        return AccountFailre(message: message);
      }, (r) => AccountSuccess(accountData: r.data)));
    });
  }
}
