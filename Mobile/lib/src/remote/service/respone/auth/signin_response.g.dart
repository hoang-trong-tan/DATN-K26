// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SigninRespone _$SigninResponeFromJson(Map<String, dynamic> json) =>
    SigninRespone()
      ..metaData = json['metaData'] == null
          ? null
          : UserModel.fromJson(json['metaData'] as Map<String, dynamic>)
      ..accessToken = json['accessToken'] as String?;

Map<String, dynamic> _$SigninResponeToJson(SigninRespone instance) =>
    <String, dynamic>{
      'metaData': instance.metaData,
      'accessToken': instance.accessToken,
    };
