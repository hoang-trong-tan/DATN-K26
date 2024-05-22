// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse<T> _$BaseResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseResponse<T>()
      ..message = json['message'] as String?
      ..status = json['code'] as int?
      ..data = _$nullableGenericFromJson(json['data'], fromJsonT);

Map<String, dynamic> _$BaseResponseToJson<T>(
  BaseResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.status,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);

DeatilCouseRespone _$DeatilCouseResponeFromJson(Map<String, dynamic> json) =>
    DeatilCouseRespone()
      ..id = json['_id'] as String?
      ..courseName = json['course_name'] as String?
      ..courseType = json['course_type'] == null
          ? null
          : CourseTypeModel.fromJson(
              json['course_type'] as Map<String, dynamic>)
      ..courseDescription = json['course_description'] as String?
      ..courseThumnail = json['course_thumnail'] as String?
      ..courseDemoVideo = json['course_demoVideo'] as String?
      ..userTeacher = json['user_teacher'] == null
          ? null
          : UserModel.fromJson(json['user_teacher'] as Map<String, dynamic>)
      ..coursePrice = json['course_price'] as int?
      ..coursePurchased = json['course_purchased'] as int?
      ..totalLength = json['total_length_video'] as int?
      ..courseRatingsAverage =
          (json['course_ratingsAverage'] as num?)?.toDouble()
      ..courseBenefits = (json['course_benefits'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..isUserReview = json['is_user_review'] as bool?
      ..courseLessonContent = (json['course_lessonContent'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..getCourseData = (json['course_data'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DeatilCouseResponeToJson(DeatilCouseRespone instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'course_name': instance.courseName,
      'course_type': instance.courseType,
      'course_description': instance.courseDescription,
      'course_thumnail': instance.courseThumnail,
      'course_demoVideo': instance.courseDemoVideo,
      'user_teacher': instance.userTeacher,
      'course_price': instance.coursePrice,
      'course_purchased': instance.coursePurchased,
      'total_length_video': instance.totalLength,
      'course_ratingsAverage': instance.courseRatingsAverage,
      'course_benefits': instance.courseBenefits,
      'is_user_review': instance.isUserReview,
      'course_lessonContent': instance.courseLessonContent,
      'course_data': instance.getCourseData,
    };
