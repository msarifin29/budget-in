part of 'privacy_bloc.dart';

sealed class PrivacyEvent extends Equatable {
  const PrivacyEvent();

  @override
  List<Object> get props => [];
}

class InitialPrivacy extends PrivacyEvent {
  const InitialPrivacy(this.lang);
  final String lang;
  @override
  List<Object> get props => [lang];
}
