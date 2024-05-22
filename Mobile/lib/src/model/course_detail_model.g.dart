// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailModel _$CourseDetailModelFromJson(Map<String, dynamic> json) =>
    CourseDetailModel()
      ..id = json['_id'] as String?
      ..videoTitle = json['video_title'] as String?
      ..videoUrl = json['video_url'] as String?
      ..videoLength = (json['video_length'] as num?)?.toDouble()
      ..isSeen = json['isSeen'] as bool?;

Map<String, dynamic> _$CourseDetailModelToJson(CourseDetailModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'video_title': instance.videoTitle,
      'video_url': instance.videoUrl,
      'video_length': instance.videoLength,
      'isSeen': instance.isSeen,
    };
