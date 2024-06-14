// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_data.g.dart';

@JsonSerializable(explicitToJson: true)
class CategoryData extends Equatable {
  @JsonKey(name: "category_id")
  final int? categoryId;
  @JsonKey(name: "t_id")
  final int? id;
  final String? title;
  const CategoryData({this.categoryId, this.id, this.title});

  static CategoryData fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);
  Map<String?, dynamic> toJson() => _$CategoryDataToJson(this);
  @override
  List<Object?> get props => [
        categoryId,
        id,
        title,
      ];
  @override
  String toString() {
    return 'CategoryData{categoryId:$categoryId, id:$id, title:$title,}';
  }
}
