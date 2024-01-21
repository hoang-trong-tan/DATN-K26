// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MusicResponse _$MusicResponseFromJson(Map<String, dynamic> json) =>
    MusicResponse()
      ..error = json['error'] as int?
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..dataList = (json['music'] as List<dynamic>?)
          ?.map((e) => MusicModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$MusicResponseToJson(MusicResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'status': instance.status,
      'message': instance.message,
      'music': instance.dataList,
    };
