import 'package:json_annotation/json_annotation.dart';

part 'signup_body.g.dart';

@JsonSerializable()
class SignupBody {
  @JsonKey(name: 'user_name')
  String? userName;

  @JsonKey(name: 'user_email')
  String? userEmail;

  @JsonKey(name: 'user_password')
  String? userPassword;

  @JsonKey(name: 'user_role')
  String? userRole;

  SignupBody();

  factory SignupBody.fromJson(Map<String, dynamic> json) =>
      _$SignupBodyFromJson(json);

  Map<String, dynamic> toJson() => _$SignupBodyToJson(this);
}
