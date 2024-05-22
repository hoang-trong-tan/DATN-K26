// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_data_video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDataVideoModel _$CourseDataVideoModelFromJson(
        Map<String, dynamic> json) =>
    CourseDataVideoModel()
      ..totalVideoSection = json['total_video_section'] as int?
      ..courseVideo = (json['course_video'] as List<dynamic>?)
          ?.map((e) => CourseDetailModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CourseDataVideoModelToJson(
        CourseDataVideoModel instance) =>
    <String, dynamic>{
      'total_video_section': instance.totalVideoSection,
      'course_video': instance.courseVideo,
    };
