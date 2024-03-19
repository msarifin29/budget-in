part of 'get_income_bloc.dart';

sealed class GetIncomeEvent extends Equatable {
  const GetIncomeEvent();

  @override
  List<Object> get props => [];
}

final class InitialIncomeEvent extends GetIncomeEvent {
  final GetIncomeParams params;

  const InitialIncomeEvent({required this.params});
  @override
  // TODO: implement props
  List<Object> get props => [params];
}
