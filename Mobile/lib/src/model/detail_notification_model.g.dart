// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailNotificationModel _$DetailNotificationModelFromJson(
        Map<String, dynamic> json) =>
    DetailNotificationModel()
      ..id = json['_id'] as String?
      ..title = json['title'] as String?
      ..description = json['message'] as String?
      ..videoId = json['videoId'] as String?
      ..courseId = json['courseId'] as String?
      ..status = json['status'] as bool?
      ..createdAt = json['createdAt'] as String?;

Map<String, dynamic> _$DetailNotificationModelToJson(
        DetailNotificationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'message': instance.description,
      'status': instance.status,
      'createdAt': instance.createdAt,
    };
