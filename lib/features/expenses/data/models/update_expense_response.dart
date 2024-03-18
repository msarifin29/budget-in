import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'update_expense_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateExpenseResponse extends Equatable {
  const UpdateExpenseResponse({required this.data});
  final bool data;
  static UpdateExpenseResponse fromJson(Map<String, dynamic> json) =>
      _$UpdateExpenseResponseFromJson(json);
  Map<String?, dynamic> toJson() => _$UpdateExpenseResponseToJson(this);
  @override
  List<Object?> get props => [data];
  @override
  String toString() {
    return 'UpdateExpenseResponse{data:$data}';
  }
}
