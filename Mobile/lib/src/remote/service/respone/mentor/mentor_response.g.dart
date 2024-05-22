// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mentor_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MentorResponse _$MentorResponseFromJson(Map<String, dynamic> json) =>
    MentorResponse()
      ..totalStudent = json['total_stuent'] as int?
      ..numberCourse = json['number_course'] as int?
      ..findTeacher = json['teacher_infor'] == null
          ? null
          : UserModel.fromJson(json['teacher_infor'] as Map<String, dynamic>)
      ..createdAt = json['createdAt'] as String?;

Map<String, dynamic> _$MentorResponseToJson(MentorResponse instance) =>
    <String, dynamic>{
      'total_stuent': instance.totalStudent,
      'number_course': instance.numberCourse,
      'teacher_infor': instance.findTeacher,
      'createdAt': instance.createdAt,
    };
