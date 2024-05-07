part of 'privacy_bloc.dart';

sealed class PrivacyState extends Equatable {
  const PrivacyState();

  @override
  List<Object> get props => [];
}

final class PrivacyInitial extends PrivacyState {}

final class PrivacyLoading extends PrivacyState {}

final class PrivacySuccess extends PrivacyState {
  final String data;

  const PrivacySuccess({required this.data});
  @override
  List<Object> get props => [data];
}

final class PrivacyFailure extends PrivacyState {
  final String message;

  const PrivacyFailure({required this.message});
  @override
  List<Object> get props => [message];
}
