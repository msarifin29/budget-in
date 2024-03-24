part of 'get_histories_credit_bloc.dart';

sealed class GetHistoriesCreditState extends Equatable {
  const GetHistoriesCreditState();

  @override
  List<Object> get props => [];
}

final class GetHistoriesCreditInitial extends GetHistoriesCreditState {}

final class GetHistoriesCreditLoading extends GetHistoriesCreditState {}

final class GetHistoriesCreditSuccess extends GetHistoriesCreditState {
  final HistoryCreditData data;
  const GetHistoriesCreditSuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class GetHistoriesCreditFailure extends GetHistoriesCreditState {
  final String message;
  const GetHistoriesCreditFailure({required this.message});
  @override
  List<Object> get props => [message];
}
