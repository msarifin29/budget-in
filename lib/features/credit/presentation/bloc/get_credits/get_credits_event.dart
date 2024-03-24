part of 'get_credits_bloc.dart';

sealed class GetCreditsEvent extends Equatable {
  const GetCreditsEvent();

  @override
  List<Object> get props => [];
}

final class InitialCreditEvent extends GetCreditsEvent {
  const InitialCreditEvent({required this.params});
  final GetCreditParams params;

  @override
  List<Object> get props => [params];
}
