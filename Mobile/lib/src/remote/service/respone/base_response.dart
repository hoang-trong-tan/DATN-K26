import 'package:json_annotation/json_annotation.dart';
import 'package:kltn/src/model/course_model.dart';

import '../../../model/course_type_model.dart';
import '../../../model/user_model.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'code')
  int? status;

  @JsonKey(name: 'data')
  T? data;

  BaseResponse();

    factory BaseResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}

@JsonSerializable()
class DeatilCouseRespone {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'course_name')
  String? courseName;

  @JsonKey(name: 'course_type')
  CourseTypeModel? courseType;

  @JsonKey(name: 'course_description')
  String? courseDescription;

  @JsonKey(name: 'course_thumnail')
  String? courseThumnail;

  @JsonKey(name: 'course_demoVideo')
  String? courseDemoVideo;

  @JsonKey(name: 'user_teacher')
  UserModel? userTeacher;

  @JsonKey(name: 'course_price')
  int? coursePrice;

  @JsonKey(name: 'course_purchased')
  int? coursePurchased;

  @JsonKey(name: 'total_length_video')
  int? totalLength;

  @JsonKey(name: 'course_ratingsAverage')
  double? courseRatingsAverage;

  @JsonKey(name: 'course_benefits')
  List<String>? courseBenefits;

  @JsonKey(name: 'is_user_review')
  bool? isUserReview;

  @JsonKey(name: 'course_lessonContent')
  List<String>? courseLessonContent;

  @JsonKey(name: 'course_data')
  List<CourseModel>? getCourseData;
  

  DeatilCouseRespone();

  factory DeatilCouseRespone.fromJson(Map<String, dynamic> json) =>
      _$DeatilCouseResponeFromJson(json);

  Map<String, dynamic> toJson() => _$DeatilCouseResponeToJson(this);
}
