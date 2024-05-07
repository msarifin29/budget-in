import 'package:bloc/bloc.dart';
import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/authentication.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

part 'privacy_event.dart';
part 'privacy_state.dart';

class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  final GetPrivacyUsecase usecase;
  PrivacyBloc(this.usecase) : super(PrivacyInitial()) {
    on<InitialPrivacy>((event, emit) async {
      emit(PrivacyLoading());
      final result = await usecase(event.lang);
      emit(result.fold((l) {
        var message = '';
        if (l is ServerFailure) {
          message = l.failure.message ?? '';
        } else if (l is ConnectionFailure) {
          message = 'Connection Faiure';
        } else if (l is ParsingFailure) {
          debugPrint(message = l.message);
        }
        return PrivacyFailure(message: message);
      }, (r) => PrivacySuccess(data: r)));
    });
  }
}
