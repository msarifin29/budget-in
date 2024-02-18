// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/domain/usecases/get_cities.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'city_event.dart';
part 'city_state.dart';

class CityBloc extends Bloc<CityEvent, CityState> {
  final GetCities getCities;
  CityBloc({required this.getCities}) : super(const CityState(cities: [])) {
    on<OnInitial>(initial);
  }

  FutureOr<void> initial(OnInitial event, Emitter<CityState> emit) async {
    final result = await getCities(NoParams());
    result.fold(
      (l) => emit(const CityState(cities: [])),
      (r) => emit(CityState(cities: r)),
    );
  }
}
