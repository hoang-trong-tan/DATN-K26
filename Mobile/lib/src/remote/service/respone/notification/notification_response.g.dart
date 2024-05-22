// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse()
      ..notifications = (json['notifications'] as List<dynamic>?)
          ?.map((e) =>
              DetailNotificationModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..numberNotification = json['number_notification'] as int?;

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'number_notification': instance.numberNotification,
    };
