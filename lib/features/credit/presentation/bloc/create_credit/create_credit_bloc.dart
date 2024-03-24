import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:equatable/equatable.dart';

part 'create_credit_event.dart';
part 'create_credit_state.dart';

class CreateCreditBloc extends Bloc<CreateCreditEvent, CreateCreditState> {
  final CreateCreditUsecase usecase;
  CreateCreditBloc({required this.usecase}) : super(CreateCreditInitial()) {
    on<OnCreated>((event, emit) async {
      emit(CreateCreditLoading());
      final result = await usecase(
        CreateCreditParams(
          uid: event.params.uid,
          categoryId: event.params.categoryId,
          typeCredit: event.params.typeCredit,
          loanTerm: event.params.loanTerm,
          installment: event.params.installment,
          paymentTime: event.params.paymentTime,
        ),
      );
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          log(message = l.message);
        }
        return CreateCreditFailure(message: message);
      }, (r) => CreateCreditSuccess(response: r.data)));
    });
  }
}
