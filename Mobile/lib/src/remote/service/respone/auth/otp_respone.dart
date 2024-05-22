import 'package:json_annotation/json_annotation.dart';

part 'otp_respone.g.dart';

@JsonSerializable()
class OtpRespone {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'user_name')
  String? userName;

  @JsonKey(name: 'user_email')
  String? userEmail;

  OtpRespone();

  factory OtpRespone.fromJson(Map<String, dynamic> json) =>
      _$OtpResponeFromJson(json);

  Map<String, dynamic> toJson() => _$OtpResponeToJson(this);
}
