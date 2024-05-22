// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartResponse _$CartResponseFromJson(Map<String, dynamic> json) => CartResponse()
  ..id = json['_id'] as String?
  ..courseShema = json['courseShema'] == null
      ? null
      : CourseShemaModel.fromJson(json['courseShema'] as Map<String, dynamic>);

Map<String, dynamic> _$CartResponseToJson(CartResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'courseShema': instance.courseShema,
    };
