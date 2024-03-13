part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class OnInitialAccount extends AccountEvent {
  final String uid;
  const OnInitialAccount({required this.uid});
  @override
  List<Object> get props => [uid];

  @override
  String toString() {
    return 'OnInitialAccount{uid:$uid}';
  }
}
