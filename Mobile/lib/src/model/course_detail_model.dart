import 'package:json_annotation/json_annotation.dart';

part 'course_detail_model.g.dart';

@JsonSerializable()
class CourseDetailModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'video_title')
  String? videoTitle;

  @JsonKey(name: 'video_url')
  String? videoUrl;

  @JsonKey(name: 'video_length')
  double? videoLength;

  @JsonKey(name: 'isSeen')
  bool? isSeen;

  CourseDetailModel();

  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailModelToJson(this);
}
