// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experience_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExperienceModel _$ExperienceModelFromJson(Map<String, dynamic> json) =>
    ExperienceModel()
      ..company = json['company'] as String?
      ..title = json['title'] as String?
      ..description = json['description'] as String?;

Map<String, dynamic> _$ExperienceModelToJson(ExperienceModel instance) =>
    <String, dynamic>{
      'company': instance.company,
      'title': instance.title,
      'description': instance.description,
    };
