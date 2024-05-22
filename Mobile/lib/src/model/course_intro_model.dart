import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'course_intro_model.g.dart';

@JsonSerializable()
class CourseIntroModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'course_name')
  String? courseName;

  @JsonKey(name: 'course_thumnail')
  String? courseThumnail;

  @JsonKey(name: 'course_price')
  int? coursePrice;

  @JsonKey(name: 'course_purchased')
  int? coursePurchased;

  @JsonKey(name: 'course_ratingsAverage')
  double? courseRatingsAverage;

  @JsonKey(name: 'is_in_cart')
  bool? isInCart;

  @JsonKey(name: 'user_teacher')
  UserModel? userTeacher;


  CourseIntroModel();

  factory CourseIntroModel.fromJson(Map<String, dynamic> json) =>
      _$CourseIntroModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseIntroModelToJson(this);
}
