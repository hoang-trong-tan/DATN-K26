import 'package:json_annotation/json_annotation.dart';

part 'experience_model.g.dart';

@JsonSerializable()
class ExperienceModel {
  @JsonKey(name: 'company')
  String? company;

  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'description')
  String? description;

  ExperienceModel();

  factory ExperienceModel.fromJson(Map<String, dynamic> json) => _$ExperienceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExperienceModelToJson(this);
}