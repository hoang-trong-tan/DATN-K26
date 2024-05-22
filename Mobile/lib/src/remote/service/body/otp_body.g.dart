// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpBody _$OtpBodyFromJson(Map<String, dynamic> json) => OtpBody()
  ..otpCode = json['otpCode'] as String?
  ..activationToken = json['activationToken'] as String?;

Map<String, dynamic> _$OtpBodyToJson(OtpBody instance) => <String, dynamic>{
      'otpCode': instance.otpCode,
      'activationToken': instance.activationToken,
    };
