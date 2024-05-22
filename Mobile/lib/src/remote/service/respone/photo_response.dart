import 'package:json_annotation/json_annotation.dart';

part 'photo_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class PhotoResponse {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'code')
  int? status;

  @JsonKey(name: 'data')
  String? data;

  PhotoResponse();

  factory PhotoResponse.fromJson(Map<String, dynamic> json) => _$PhotoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoResponseToJson(this);
}
