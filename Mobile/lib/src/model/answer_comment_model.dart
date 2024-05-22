import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'answer_comment_model.g.dart';

@JsonSerializable()
class AnswerCommentModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'userId')
  UserModel? userId;

  @JsonKey(name: 'answser_comment')
  String? answserComment;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  AnswerCommentModel();

  factory AnswerCommentModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerCommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$AnswerCommentModelToJson(this);
}