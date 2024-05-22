// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProcessModel _$ProcessModelFromJson(Map<String, dynamic> json) => ProcessModel()
  ..processCourse = (json['process_Course'] as num?)?.toDouble()
  ..courseInfo = json['_id'] == null
      ? null
      : CourseShemaModel.fromJson(json['_id'] as Map<String, dynamic>);

Map<String, dynamic> _$ProcessModelToJson(ProcessModel instance) =>
    <String, dynamic>{
      'process_Course': instance.processCourse,
      '_id': instance.courseInfo,
    };
