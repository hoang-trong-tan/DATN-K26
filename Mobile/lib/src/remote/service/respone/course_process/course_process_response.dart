import 'package:json_annotation/json_annotation.dart';

import '../../../../model/process_model.dart';

part 'course_process_response.g.dart';

@JsonSerializable()
class CourseProcessResponse {
  @JsonKey(name: '_id')
  String? id;


  @JsonKey(name: 'user_course')
  List<ProcessModel>? userCourse;


  CourseProcessResponse();

  factory CourseProcessResponse.fromJson(Map<String, dynamic> json) => _$CourseProcessResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseProcessResponseToJson(this);
}
