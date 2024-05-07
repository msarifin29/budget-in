import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:budget_in/features/authentication/data/datasources/auth_remote_datasource.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUsecase usecase;
  ResetPasswordBloc({required this.usecase}) : super(ResetPasswordInitial()) {
    on<InitialReset>((event, emit) async {
      emit(ResetPasswordLoading());
      final result = await usecase(
        ResetPasswordParam(
          oldPassword: event.oldPassword,
          newPassword: event.newPassword,
        ),
      );
      emit(
        result.fold((l) {
          var message = '';
          if (l is ServerFailure) {
            message = l.failure.message ?? '';
          } else if (l is ConnectionFailure) {
            message = 'Connection Faiure';
          } else if (l is ParsingFailure) {
            debugPrint(message = l.message);
          }
          return ResetPasswordFailure(message: message);
        }, (r) => ResetPasswordSuccess(response: r)),
      );
    });
  }
}
