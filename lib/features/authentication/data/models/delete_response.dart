import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'delete_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DeleteResponse extends Equatable {
  const DeleteResponse({required this.data});
  final bool data;
  static DeleteResponse fromJson(Map<String, dynamic> json) =>
      _$DeleteResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$DeleteResponseToJson(this);
  @override
  List<Object?> get props => [data];
}
