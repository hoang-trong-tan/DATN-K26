import 'package:json_annotation/json_annotation.dart';

part 'otp_body.g.dart';

@JsonSerializable()
class OtpBody {
  @JsonKey(name: 'otpCode')
  String? otpCode;

  @JsonKey(name: 'activationToken')
  String? activationToken;

  OtpBody();

  factory OtpBody.fromJson(Map<String, dynamic> json) =>
      _$OtpBodyFromJson(json);

  Map<String, dynamic> toJson() => _$OtpBodyToJson(this);
}
