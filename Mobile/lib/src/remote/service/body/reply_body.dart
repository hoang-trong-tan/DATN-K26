import 'package:json_annotation/json_annotation.dart';

part 'reply_body.g.dart';

@JsonSerializable()
class ReplyCommentBody {
  @JsonKey(name: 'courseId')
  String? courseId;

  @JsonKey(name: 'reply_comment')
  String? replyComment;

  ReplyCommentBody();

  factory ReplyCommentBody.fromJson(Map<String, dynamic> json) => _$ReplyCommentBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReplyCommentBodyToJson(this);
}
