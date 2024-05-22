// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizBody _$QuizBodyFromJson(Map<String, dynamic> json) => QuizBody()
  ..questionId = json['questionId'] as String?
  ..answersOption = json['answers_option'] as int?;

Map<String, dynamic> _$QuizBodyToJson(QuizBody instance) => <String, dynamic>{
      'questionId': instance.questionId,
      'answers_option': instance.answersOption,
    };
