// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:equatable/equatable.dart';

import 'package:budget_in/features/authentication/authentication.dart';
import 'package:flutter/rendering.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUsecase loginUsecase;
  LoginBloc({
    required this.loginUsecase,
  }) : super(LoginInitial()) {
    on<OnUserLogin>((event, emit) async {
      emit(LoginLoading());
      final result = await loginUsecase(
          LoginParams(email: event.email, password: event.password));
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          debugPrint(message = l.message);
        }

        return LoginFailure(message: message);
      }, (r) => LoginSuccess(data: r.data)));
    });
  }
}
