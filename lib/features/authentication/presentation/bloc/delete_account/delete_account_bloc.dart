import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:equatable/equatable.dart';

part 'delete_account_event.dart';
part 'delete_account_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  final DeleteAccountUsecase usecase;
  DeleteAccountBloc({required this.usecase}) : super(DeleteAccountInitial()) {
    on<DeleteAccountEvent>((event, emit) async {
      emit(DeleteAccountLoading());
      final result = await usecase(NoParams());
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          log(message = l.message);
        }
        return DeleteAccountFailure(message: message);
      }, (r) => DeleteAccountSuccess(response: r)));
    });
  }
}
