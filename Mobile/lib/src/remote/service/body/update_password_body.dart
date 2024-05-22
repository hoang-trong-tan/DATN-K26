import 'package:json_annotation/json_annotation.dart';

part 'update_password_body.g.dart';

@JsonSerializable()
class UpdatePasswordBody {
  @JsonKey(name: 'old_passWord')
  String? oldPassWord;

  @JsonKey(name: 'new_passWord')
  String? newPassword;

  UpdatePasswordBody();

  factory UpdatePasswordBody.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordBodyToJson(this);
}
