import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dynamic_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DynamicResponse extends Equatable {
  const DynamicResponse({required this.data});
  final bool data;
  static DynamicResponse fromJson(Map<String, dynamic> json) =>
      _$DynamicResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$DynamicResponseToJson(this);
  @override
  List<Object?> get props => [data];
}
