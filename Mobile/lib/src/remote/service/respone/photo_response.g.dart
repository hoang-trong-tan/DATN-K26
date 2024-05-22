// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoResponse _$PhotoResponseFromJson(Map<String, dynamic> json) =>
    PhotoResponse()
      ..message = json['message'] as String?
      ..status = json['code'] as int?
      ..data = json['data'] as String?;

Map<String, dynamic> _$PhotoResponseToJson(PhotoResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.status,
      'data': instance.data,
    };
