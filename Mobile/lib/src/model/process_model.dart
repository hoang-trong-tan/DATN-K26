import 'package:json_annotation/json_annotation.dart';

import 'course_shema_model.dart';

part 'process_model.g.dart';

@JsonSerializable()
class ProcessModel {
  @JsonKey(name: 'process_Course')
  double? processCourse;

  @JsonKey(name: '_id')
  CourseShemaModel? courseInfo;

  ProcessModel();

  factory ProcessModel.fromJson(Map<String, dynamic> json) => _$ProcessModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProcessModelToJson(this);
}