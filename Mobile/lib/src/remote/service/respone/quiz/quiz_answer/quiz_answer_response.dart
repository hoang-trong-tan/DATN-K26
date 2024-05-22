import 'package:json_annotation/json_annotation.dart';
import 'package:kltn/src/remote/service/respone/quiz/quiz_response.dart';


part 'quiz_answer_response.g.dart';

@JsonSerializable()
class QuizAnswerResponse {
  @JsonKey(name: 'quiz_scores')
  double? quizScores;


  @JsonKey(name: 'printResults')
  List<QuizResponse>? printResults;

  QuizAnswerResponse();

  factory QuizAnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QuizAnswerResponseToJson(this);
}
