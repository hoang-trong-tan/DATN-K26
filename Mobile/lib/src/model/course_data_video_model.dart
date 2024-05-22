import 'package:json_annotation/json_annotation.dart';
import 'package:kltn/src/model/course_detail_model.dart';


part 'course_data_video_model.g.dart';

@JsonSerializable()
class CourseDataVideoModel {


  @JsonKey(name: 'total_video_section')
  int? totalVideoSection;

  @JsonKey(name: 'course_video')
  List<CourseDetailModel>? courseVideo;


  CourseDataVideoModel();

  factory CourseDataVideoModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDataVideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDataVideoModelToJson(this);
}