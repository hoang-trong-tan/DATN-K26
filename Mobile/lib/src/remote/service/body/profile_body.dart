import 'package:json_annotation/json_annotation.dart';

import '../../../model/experience_model.dart';


part 'profile_body.g.dart';

@JsonSerializable()
class ProfileBody {
  @JsonKey(name: 'user_name')
  String? userName;

  @JsonKey(name: 'user_experience')
  List<ExperienceModel>? userExperience;
  
  @JsonKey(name: 'user_avatar')
  String? userAvatar;
  
  @JsonKey(name: 'user_phone')
  String? userPhone;
  
  @JsonKey(name: 'user_birthday')
  String? userBirthday;
  

  ProfileBody();

  factory ProfileBody.fromJson(Map<String, dynamic> json) => _$ProfileBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileBodyToJson(this);
}
