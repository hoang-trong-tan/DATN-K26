import 'package:json_annotation/json_annotation.dart';
import 'experience_model.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'user_name')
  String? userName;

  @JsonKey(name: 'user_email')
  String? userEmail;

  @JsonKey(name: 'user_about')
  String? userAbout;

  @JsonKey(name: 'user_role')
  String? userRole;

  @JsonKey(name: 'user_experience')
  List<ExperienceModel>? userExperience;

  @JsonKey(name: 'user_avatar')
  String? userAvatar;

  @JsonKey(name: 'user_phone')
  String? userPhone;

  @JsonKey(name: 'user_birthday')
  String? userBirthday;

  @JsonKey(name: 'user_university')
  String? userUniversity;

  @JsonKey(name: 'user_fcm_token')
  String? userFcmToken;

  @JsonKey(name: 'course_type')
  dynamic courseType;

  UserModel();

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
