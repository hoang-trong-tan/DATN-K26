// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileBody _$ProfileBodyFromJson(Map<String, dynamic> json) => ProfileBody()
  ..userName = json['user_name'] as String?
  ..userExperience = (json['user_experience'] as List<dynamic>?)
      ?.map((e) => ExperienceModel.fromJson(e as Map<String, dynamic>))
      .toList()
  ..userAvatar = json['user_avatar'] as String?
  ..userPhone = json['user_phone'] as String?
  ..userBirthday = json['user_birthday'] as String?;

Map<String, dynamic> _$ProfileBodyToJson(ProfileBody instance) => <String, dynamic>{
      'user_name': instance.userName,
      'user_experience': instance.userExperience,
      'user_avatar': instance.userAvatar,
      'user_phone': instance.userPhone,
      'user_birthday': instance.userBirthday,
    };
