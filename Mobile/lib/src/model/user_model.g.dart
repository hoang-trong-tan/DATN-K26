// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel()
  ..id = json['_id'] as String?
  ..userName = json['user_name'] as String?
  ..userEmail = json['user_email'] as String?
  ..userAbout = json['user_about'] as String?
  ..userRole = json['user_role'] as String?
  ..userPhone = json['user_phone'] as String?
  ..userBirthday = json['user_birthday'] as String?
  ..userUniversity = json['user_university'] as String?
  ..userFcmToken = json['user_fcm_token'] as String?
  ..courseType = json['course_type']
  ..userExperience = (json['user_experience'] as List<dynamic>?)
      ?.map((e) => ExperienceModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..userAvatar = json['user_avatar'] as String?;

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'user_name': instance.userName,
      'user_email': instance.userEmail,
      'user_about': instance.userAbout,
      'user_role': instance.userRole,
      'user_experience': instance.userExperience,
      'user_phone': instance.userPhone,
      'user_birthday': instance.userBirthday,
      'user_university': instance.userUniversity,
      'course_type': instance.courseType,
      'user_fcm_token': instance.userFcmToken,
      'user_avatar': instance.userAvatar,
    };
