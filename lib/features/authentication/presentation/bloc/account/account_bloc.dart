// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/injection.dart';
import 'package:equatable/equatable.dart';

import 'package:budget_in/features/authentication/authentication.dart';
import 'package:flutter/rendering.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountUsecase accountUsecase;
  AccountBloc({required this.accountUsecase}) : super(AccountInitial()) {
    on<OnInitialAccount>((event, emit) async {
      emit(AccountLoading());
      final dataSource = sl<SharedPreferencesManager>();
      final result = await accountUsecase(event.uid);
      emit(result.fold((l) {
        var message = '';
        int? code;
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          debugPrint(message = l.message);
        } else if (l is ErrorResponseFailure) {
          final error = l.errorResponse;
          code = error.code;
        }
        return AccountFailre(message: message, code: code);
      }, (r) {
        if ((dataSource.getString(SharedPreferencesManager.keyAccountId) ?? '')
            .isEmpty) {
          dataSource.putString(
              SharedPreferencesManager.keyAccountId, r.data.accountId);
        }
        return AccountSuccess(accountData: r.data);
      }));
    });
  }
}
