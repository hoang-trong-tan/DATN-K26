import 'package:json_annotation/json_annotation.dart';

part 'signup_respone.g.dart';

@JsonSerializable()
class SignupRespone {
  @JsonKey(name: 'activationToken')
  String? activationToken;

  SignupRespone();

  factory SignupRespone.fromJson(Map<String, dynamic> json) =>
      _$SignupResponeFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponeToJson(this);
}
