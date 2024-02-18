// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'occupation_bloc.dart';

class OccupationState extends Equatable {
  const OccupationState({required this.occupations});
  final List<String> occupations;

  @override
  List<Object> get props => [occupations];
}
