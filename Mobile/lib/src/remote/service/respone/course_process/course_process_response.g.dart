// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_process_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseProcessResponse _$CourseProcessResponseFromJson(
        Map<String, dynamic> json) =>
    CourseProcessResponse()
      ..id = json['_id'] as String?
      ..userCourse = (json['user_course'] as List<dynamic>?)
          ?.map((e) => ProcessModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CourseProcessResponseToJson(
        CourseProcessResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_course': instance.userCourse,
    };
