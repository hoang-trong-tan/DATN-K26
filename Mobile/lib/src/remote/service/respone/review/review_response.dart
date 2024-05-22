import 'package:json_annotation/json_annotation.dart';
import 'package:kltn/src/model/user_model.dart';
import 'package:kltn/src/remote/service/respone/review/reply_comment_respone.dart';

part 'review_response.g.dart';

@JsonSerializable()
class ReviewResponse {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'userId')
  UserModel? userId;

  @JsonKey(name: 'review_rating')
  int? reviewRating;

  @JsonKey(name: 'review_comment')
  String? reviewComment;

  @JsonKey(name: 'createdAt')
  String? createdAt;

  @JsonKey(name: 'reply_comment')
  ReplyCommentResponse? replyComment;

  ReviewResponse();

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => _$ReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewResponseToJson(this);
}
