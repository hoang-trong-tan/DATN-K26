// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseTypeModel _$CourseTypeModelFromJson(Map<String, dynamic> json) =>
    CourseTypeModel()
      ..id = json['_id'] as String?
      ..typeThumnail = json['type_thumnail'] as String?
      ..typeName = json['type_name'] as String?;

Map<String, dynamic> _$CourseTypeModelToJson(CourseTypeModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type_thumnail': instance.typeThumnail,
      'type_name': instance.typeName,
    };
