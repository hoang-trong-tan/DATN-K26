import 'package:json_annotation/json_annotation.dart';
import 'package:kltn/src/model/user_model.dart';

part 'reply_comment_respone.g.dart';

@JsonSerializable()
class ReplyCommentResponse {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'userId')
  UserModel? userId;

  @JsonKey(name: 'reply_comment')
  String? replyComment;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  ReplyCommentResponse();

  factory ReplyCommentResponse.fromJson(Map<String, dynamic> json) => _$ReplyCommentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyCommentResponseToJson(this);
}
