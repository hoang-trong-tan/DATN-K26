import 'package:json_annotation/json_annotation.dart';

part 'detail_notification_model.g.dart';

@JsonSerializable()
class DetailNotificationModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'message')
  String? description;

  @JsonKey(name: 'courseId')
  String? courseId;

  @JsonKey(name: 'videoId')
  String? videoId;

  @JsonKey(name: 'status')
  bool? status;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  DetailNotificationModel();

  factory DetailNotificationModel.fromJson(Map<String, dynamic> json) => _$DetailNotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$DetailNotificationModelToJson(this);
}