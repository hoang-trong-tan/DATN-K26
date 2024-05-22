// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionBody _$QuestionBodyFromJson(Map<String, dynamic> json) => QuestionBody()
  ..courseId = json['courseId'] as String?
  ..questionComment = json['question_comment'] as String?
  ..videoTime = json['video_time'] as int?;

Map<String, dynamic> _$QuestionBodyToJson(QuestionBody instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'question_comment': instance.questionComment,
      'video_time': instance.videoTime,
    };
