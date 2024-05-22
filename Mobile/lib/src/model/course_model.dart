import 'package:json_annotation/json_annotation.dart';

import 'course_data_video_model.dart';
import 'quiz_title_model.dart';

part 'course_model.g.dart';

@JsonSerializable()
class CourseModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'courseData_title')
  String? courseDataTitle;

  @JsonKey(name: 'course_data_video')
  CourseDataVideoModel? courseDataVideo;

  @JsonKey(name: 'course_data_quiz')
  List<QuizTitleModel>? courseDataQuiz;

  CourseModel();

  factory CourseModel.fromJson(Map<String, dynamic> json) => _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}
