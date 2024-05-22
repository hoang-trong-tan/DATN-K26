// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewResponse _$ReviewResponseFromJson(Map<String, dynamic> json) => ReviewResponse()
  ..id = json['_id'] as String?
  ..userId = json['userId'] == null ? null : UserModel.fromJson(json['userId'] as Map<String, dynamic>)
  ..reviewRating = json['review_rating'] as int?
  ..reviewComment = json['review_comment'] as String?
  ..createdAt = json['createdAt'] as String?
  ..replyComment = json['reply_comment'] == null
      ? null
      : ReplyCommentResponse.fromJson(json['reply_comment'] as Map<String, dynamic>);

Map<String, dynamic> _$ReviewResponseToJson(ReviewResponse instance) => <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'review_rating': instance.reviewRating,
      'review_comment': instance.reviewComment,
      'createdAt': instance.createdAt,
      'reply_comment': instance.replyComment,
    };
