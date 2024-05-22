import 'package:json_annotation/json_annotation.dart';


part 'quiz_body.g.dart';

@JsonSerializable()

class QuizBody {
  @JsonKey(name: 'questionId')
  String? questionId;

  @JsonKey(name: 'answers_option')
  int? answersOption;

  QuizBody();

  factory QuizBody.fromJson(Map<String, dynamic> json) =>
      _$QuizBodyFromJson(json);

  Map<String, dynamic> toJson() => _$QuizBodyToJson(this);
}
