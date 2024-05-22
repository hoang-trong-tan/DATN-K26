import 'package:json_annotation/json_annotation.dart';

part 'vnpay_response.g.dart';

@JsonSerializable()
class VnpayRespone {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  String? url;

  VnpayRespone();

  factory VnpayRespone.fromJson(Map<String, dynamic> json) => _$VnpayResponeFromJson(json);

  Map<String, dynamic> toJson() => _$VnpayResponeToJson(this);
}
