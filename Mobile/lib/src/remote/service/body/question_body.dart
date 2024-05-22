import 'package:json_annotation/json_annotation.dart';

part 'question_body.g.dart';

@JsonSerializable()
class QuestionBody {
  @JsonKey(name: 'courseId')
  String? courseId;

  @JsonKey(name: 'question_comment')
  String? questionComment;

  @JsonKey(name: 'video_time')
  int? videoTime;

  QuestionBody();

  factory QuestionBody.fromJson(Map<String, dynamic> json) => _$QuestionBodyFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionBodyToJson(this);
}
