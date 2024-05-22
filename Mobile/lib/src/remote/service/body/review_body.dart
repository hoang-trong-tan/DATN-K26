import 'package:json_annotation/json_annotation.dart';

part 'review_body.g.dart';

@JsonSerializable()
class ReviewBody {
  @JsonKey(name: 'review_rating')
  int? reviewRating;

  @JsonKey(name: 'review_comment')
  String? reviewComment;
  ReviewBody();

  factory ReviewBody.fromJson(Map<String, dynamic> json) => _$ReviewBodyFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewBodyToJson(this);
}
