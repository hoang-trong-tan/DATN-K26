// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupBody _$SignupBodyFromJson(Map<String, dynamic> json) => SignupBody()
  ..userName = json['user_name'] as String?
  ..userEmail = json['user_email'] as String?
  ..userRole = json['user_role'] as String?
  ..userPassword = json['user_password'] as String?;

Map<String, dynamic> _$SignupBodyToJson(SignupBody instance) => <String, dynamic>{
      'user_name': instance.userName,
      'user_email': instance.userEmail,
      'user_password': instance.userPassword,
      'user_role': instance.userRole,
    };
