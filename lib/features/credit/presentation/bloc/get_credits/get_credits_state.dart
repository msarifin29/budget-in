part of 'get_credits_bloc.dart';

sealed class GetCreditsState extends Equatable {
  const GetCreditsState();

  @override
  List<Object> get props => [];
}

final class GetCreditsInitial extends GetCreditsState {}

final class GetCreditsLoading extends GetCreditsState {}

final class GetCreditsSuccess extends GetCreditsState {
  final GetCreditResponse response;

  const GetCreditsSuccess({required this.response});
  @override
  List<Object> get props => [response];
}

final class GetCreditsFailure extends GetCreditsState {
  final String message;

  const GetCreditsFailure({required this.message});
  @override
  List<Object> get props => [message];
}
