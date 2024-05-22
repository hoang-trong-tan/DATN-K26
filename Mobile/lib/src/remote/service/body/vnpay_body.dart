import 'package:json_annotation/json_annotation.dart';

part 'vnpay_body.g.dart';

@JsonSerializable()
class VnpayBody {
  @JsonKey(name: 'courseId')
  String? courseId;

  VnpayBody();

  factory VnpayBody.fromJson(Map<String, dynamic> json) =>
      _$VnpayBodyFromJson(json);

  Map<String, dynamic> toJson() => _$VnpayBodyToJson(this);
}
