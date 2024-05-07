import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/credit/credits.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'pay_credit_event.dart';
part 'pay_credit_state.dart';

class PayCreditBloc extends Bloc<PayCreditEvent, PayCreditState> {
  final PayCreditUsecase usecase;
  PayCreditBloc({required this.usecase}) : super(PayCreditInitial()) {
    on<InitialPaymentEvent>((event, emit) async {
      emit(PayCreditLoading());
      final result = await usecase(
        UpdateCreditParams(
          uid: event.params.uid,
          creditId: event.params.creditId,
          id: event.params.id,
          typePayment: event.params.typePayment,
          accountId: event.params.accountId,
        ),
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
        return PayCreditFailure(message: message);
      }, (r) => PayCreditSuccess(data: r.data)));
    });
  }
}
