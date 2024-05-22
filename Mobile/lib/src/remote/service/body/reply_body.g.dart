// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reply_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReplyCommentBody _$ReplyCommentBodyFromJson(Map<String, dynamic> json) =>
    ReplyCommentBody()
      ..courseId = json['courseId'] as String?
      ..replyComment = json['reply_comment'] as String?;

Map<String, dynamic> _$ReplyCommentBodyToJson(ReplyCommentBody instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'reply_comment': instance.replyComment,
    };
