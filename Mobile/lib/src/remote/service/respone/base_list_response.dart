import 'package:json_annotation/json_annotation.dart';

part 'base_list_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseListResponse<T> {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'code')
  int? status;

  @JsonKey(name: 'data')
  List<T>? data;

  BaseListResponse();

    factory BaseListResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseListResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseListResponseToJson(this, toJsonT);
}