import 'package:budget_in/core/core.dart';
import 'package:budget_in/features/authentication/domain/usecases/get_occupations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'occupation_event.dart';
part 'occupation_state.dart';

class OccupationBloc extends Bloc<OccupationEvent, OccupationState> {
  OccupationBloc({required this.getOccupations})
      : super(const OccupationState(occupations: [])) {
    on<OnInitialOccupation>((event, emit) async {
      final result = await getOccupations(NoParams());
      result.fold(
        (l) => emit(const OccupationState(occupations: [])),
        (r) => emit(OccupationState(occupations: r)),
      );
    });
  }
  final GetOccupations getOccupations;
}
