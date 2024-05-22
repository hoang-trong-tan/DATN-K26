// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizResponse _$QuizResponseFromJson(Map<String, dynamic> json) => QuizResponse()
  ..id = json['_id'] as String?
  ..quizQuestions = json['quiz_questions'] as String?
  ..quizCorrectAnswer = json['quiz_correctAnswer'] as int?
  ..answersOption = json['answers_option'] as int?
  ..isCorrect = json['isCorrect'] as bool?
  ..quizOptions = (json['quiz_options'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList();

Map<String, dynamic> _$QuizResponseToJson(QuizResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'quiz_questions': instance.quizQuestions,
      'quiz_correctAnswer': instance.quizCorrectAnswer,
      'answers_option': instance.answersOption,
      'isCorrect': instance.isCorrect,
      'quiz_options': instance.quizOptions,
    };
