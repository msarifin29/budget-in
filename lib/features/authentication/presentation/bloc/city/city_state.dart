// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'city_bloc.dart';

class CityState extends Equatable {
  const CityState({required this.cities});

  final List<String> cities;

  @override
  List<Object> get props => [cities];
}
