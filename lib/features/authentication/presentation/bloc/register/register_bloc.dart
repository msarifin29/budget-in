// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:equatable/equatable.dart';

import 'package:budget_in/features/authentication/authentication.dart';
import 'package:flutter/rendering.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUsecase registerUsecase;
  final ExistingEmailUsecase existingEmailUsecase;
  RegisterBloc({
    required this.registerUsecase,
    required this.existingEmailUsecase,
  }) : super(RegisterInitial()) {
    on<OnUserRegister>((event, emit) async {
      emit(RegisterLoading());
      final result = await registerUsecase(
        RegisterParams(
            email: event.email,
            password: event.password,
            username: event.username,
            balance: event.balance,
            cash: event.cash),
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

        return RegisterFailure(message: message);
      }, (r) => RegisterSuccess(data: r.data)));
    });
    on<ExistingEmail>((event, emit) async {
      emit(ExistingEmailLoading());
      final result = await existingEmailUsecase(event.email);
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          debugPrint(message = l.message);
        }

        return ExistingEmailFailure(message: message);
      }, (r) => ExistingEmailSuccess(isExist: r.data)));
    });
  }
}
