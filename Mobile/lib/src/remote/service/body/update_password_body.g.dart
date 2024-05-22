// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordBody _$UpdatePasswordBodyFromJson(Map<String, dynamic> json) =>
    UpdatePasswordBody()
      ..oldPassWord = json['old_passWord'] as String?
      ..newPassword = json['new_passWord'] as String?;

Map<String, dynamic> _$UpdatePasswordBodyToJson(UpdatePasswordBody instance) =>
    <String, dynamic>{
      'old_passWord': instance.oldPassWord,
      'new_passWord': instance.newPassword,
    };
