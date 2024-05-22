import 'package:json_annotation/json_annotation.dart';

part 'base_auth_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseAuthResponse<T> {
  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'code')
  int? status;

  @JsonKey(name: 'data')
  T? data;

  BaseAuthResponse();

    factory BaseAuthResponse.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseAuthResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseAuthResponseToJson(this, toJsonT);
}