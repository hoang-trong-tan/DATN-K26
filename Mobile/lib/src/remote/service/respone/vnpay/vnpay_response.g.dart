// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vnpay_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VnpayRespone _$VnpayResponeFromJson(Map<String, dynamic> json) => VnpayRespone()
  ..message = json['message'] as String?
  ..code = json['code'] as int?
  ..url = json['data'] as String?;

Map<String, dynamic> _$VnpayResponeToJson(VnpayRespone instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.url,
    };
