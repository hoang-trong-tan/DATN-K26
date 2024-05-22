import 'package:json_annotation/json_annotation.dart';


part 'quiz_response.g.dart';

@JsonSerializable()
class QuizResponse {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'quiz_questions')
  String? quizQuestions;

  @JsonKey(name: 'quiz_correctAnswer')
  int? quizCorrectAnswer;

  @JsonKey(name: 'answers_option')
  int? answersOption;

  @JsonKey(name: 'isCorrect')
  bool? isCorrect;

  @JsonKey(name: 'quiz_options')
  List<String>? quizOptions;

  QuizResponse();

  factory QuizResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResponseToJson(this);
}
