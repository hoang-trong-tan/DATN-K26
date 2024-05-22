import 'package:json_annotation/json_annotation.dart';

import '../../../../model/user_model.dart';

part 'signin_response.g.dart';

@JsonSerializable()
class SigninRespone {
  @JsonKey(name: 'metaData')
  UserModel? metaData;

  @JsonKey(name: 'accessToken')
  String? accessToken;

  SigninRespone();

  factory SigninRespone.fromJson(Map<String, dynamic> json) => _$SigninResponeFromJson(json);

  Map<String, dynamic> toJson() => _$SigninResponeToJson(this);
}
