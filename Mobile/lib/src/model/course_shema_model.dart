import 'package:json_annotation/json_annotation.dart';

import 'user_model.dart';

part 'course_shema_model.g.dart';

@JsonSerializable()
class CourseShemaModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'course_name')
  String? courseName;

  @JsonKey(name: 'course_type')
  dynamic courseType;

  @JsonKey(name: 'course_thumnail')
  String? courseThumnail;

  @JsonKey(name: 'course_price')
  int? coursePrice;

  @JsonKey(name: 'course_ratingsAverage')
  double? courseRatingsAverage;

  @JsonKey(name: 'course_purchased')
  int? coursePurchased;

  @JsonKey(name: 'user_teacher')
  UserModel? userTeacher;

  @JsonKey(name: 'is_in_cart')
  bool? isInCart;


  CourseShemaModel();

  factory CourseShemaModel.fromJson(Map<String, dynamic> json) => _$CourseShemaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseShemaModelToJson(this);
}
