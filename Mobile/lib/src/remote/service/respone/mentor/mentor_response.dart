import 'package:json_annotation/json_annotation.dart';
import 'package:kltn/src/model/user_model.dart';

part 'mentor_response.g.dart';

@JsonSerializable()
class MentorResponse {
  @JsonKey(name: 'total_stuent')
  int? totalStudent;

  @JsonKey(name: 'number_course')
  int? numberCourse;

  @JsonKey(name: 'teacher_infor')
  UserModel? findTeacher;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  MentorResponse();

  factory MentorResponse.fromJson(Map<String, dynamic> json) => _$MentorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MentorResponseToJson(this);
}
