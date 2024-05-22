// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewBody _$ReviewBodyFromJson(Map<String, dynamic> json) => ReviewBody()
  ..reviewRating = json['review_rating'] as int?
  ..reviewComment = json['review_comment'] as String?;

Map<String, dynamic> _$ReviewBodyToJson(ReviewBody instance) =>
    <String, dynamic>{
      'review_rating': instance.reviewRating,
      'review_comment': instance.reviewComment,
    };
