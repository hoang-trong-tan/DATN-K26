// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseListResponse<T> _$BaseListResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseListResponse<T>()
      ..message = json['message'] as String?
      ..status = json['code'] as int?
      ..data = (json['data'] as List<dynamic>?)?.map(fromJsonT).toList();

Map<String, dynamic> _$BaseListResponseToJson<T>(
  BaseListResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.status,
      'data': instance.data?.map(toJsonT).toList(),
    };
