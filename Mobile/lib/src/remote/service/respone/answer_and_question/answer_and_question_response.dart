import 'package:json_annotation/json_annotation.dart';
import 'package:kltn/src/model/answer_comment_model.dart';

import '../../../../model/user_model.dart';

part 'answer_and_question_response.g.dart';

@JsonSerializable()
class AnswerAndQuestionRespone {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'userId')
  UserModel? userId;

  @JsonKey(name: 'question_comment')
  String? questionComment;

  @JsonKey(name: 'video_time')
  int? videoTime;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'answser_comment')
  List<AnswerCommentModel>? answserComment;

  AnswerAndQuestionRespone();

  factory AnswerAndQuestionRespone.fromJson(Map<String, dynamic> json) => _$AnswerAndQuestionResponeFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerAndQuestionResponeToJson(this);
}
