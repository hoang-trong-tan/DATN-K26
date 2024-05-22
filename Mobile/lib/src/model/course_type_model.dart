import 'package:json_annotation/json_annotation.dart';

part 'course_type_model.g.dart';

@JsonSerializable()
class CourseTypeModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'type_name')
  String? typeName;

  @JsonKey(name: 'type_thumnail')
  String? typeThumnail;

  CourseTypeModel();

  factory CourseTypeModel.fromJson(Map<String, dynamic> json) =>
      _$CourseTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseTypeModelToJson(this);
}
