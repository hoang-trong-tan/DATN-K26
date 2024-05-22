// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_intro_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseIntroModel _$CourseIntroModelFromJson(Map<String, dynamic> json) =>
    CourseIntroModel()
      ..id = json['_id'] as String?
      ..courseName = json['course_name'] as String?
      ..courseThumnail = json['course_thumnail'] as String?
      ..coursePrice = json['course_price'] as int?
      ..coursePurchased = json['course_purchased'] as int?
      ..courseRatingsAverage =
          (json['course_ratingsAverage'] as num?)?.toDouble()
      ..isInCart = json['is_in_cart'] as bool?
      ..userTeacher = json['user_teacher'] == null
          ? null
          : UserModel.fromJson(json['user_teacher'] as Map<String, dynamic>);

Map<String, dynamic> _$CourseIntroModelToJson(CourseIntroModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'course_name': instance.courseName,
      'course_thumnail': instance.courseThumnail,
      'course_price': instance.coursePrice,
      'course_ratingsAverage': instance.courseRatingsAverage,
      'is_in_cart': instance.isInCart,
      'course_purchased': instance.coursePurchased,
      'user_teacher': instance.userTeacher,
    };
