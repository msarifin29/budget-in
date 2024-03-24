part of 'get_histories_credit_bloc.dart';

sealed class GetHistoriesCreditEvent extends Equatable {
  const GetHistoriesCreditEvent();

  @override
  List<Object> get props => [];
}

final class InitialHistoriesEvent extends GetHistoriesCreditEvent {
  const InitialHistoriesEvent({required this.params});
  final GetHistorisCreditParams params;

  @override
  List<Object> get props => [params];
}
