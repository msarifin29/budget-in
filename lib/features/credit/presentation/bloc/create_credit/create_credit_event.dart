part of 'create_credit_bloc.dart';

sealed class CreateCreditEvent extends Equatable {
  const CreateCreditEvent();

  @override
  List<Object> get props => [];
}

final class OnCreated extends CreateCreditEvent {
  const OnCreated({required this.params});
  final CreateCreditParams params;
  @override
  List<Object> get props => [params];
}
