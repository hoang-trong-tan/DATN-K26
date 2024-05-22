import 'package:json_annotation/json_annotation.dart';
import '../../../../model/detail_notification_model.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  @JsonKey(name: 'notifications')
  List<DetailNotificationModel>? notifications;

  @JsonKey(name: 'number_notification')
  int? numberNotification;

  NotificationResponse();

  factory NotificationResponse.fromJson(Map<String, dynamic> json) => _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}