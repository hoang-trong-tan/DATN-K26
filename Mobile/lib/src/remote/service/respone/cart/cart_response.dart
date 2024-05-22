import 'package:json_annotation/json_annotation.dart';

import '../../../../model/course_shema_model.dart';

part 'cart_response.g.dart';

@JsonSerializable()
class CartResponse {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'courseShema')
  CourseShemaModel? courseShema;

  CartResponse();

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}
