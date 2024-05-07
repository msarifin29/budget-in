import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordUsecase usecase;
  ForgotPasswordBloc({required this.usecase}) : super(ForgotPasswordInitial()) {
    on<OnReset>((event, emit) async {
      emit(ForgotPasswordLoading());
      final result = await usecase(ForgotPasswordParam(email: event.email));
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          debugPrint(message = l.message);
        }
        return ForgotPasswordFailure(message: message);
      }, (r) => ForgotPasswordSuccess(response: r)));
    });
  }
}
