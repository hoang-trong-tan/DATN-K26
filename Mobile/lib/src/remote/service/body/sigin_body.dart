import 'package:json_annotation/json_annotation.dart';

part 'sigin_body.g.dart';

@JsonSerializable()
class SigninBody {
  @JsonKey(name: 'user_email')
  String? userEmail;

  @JsonKey(name: 'user_password')
  String? userPassword;

  SigninBody();

  factory SigninBody.fromJson(Map<String, dynamic> json) => _$SigninBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SigninBodyToJson(this);
}
