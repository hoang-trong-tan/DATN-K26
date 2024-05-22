import 'package:json_annotation/json_annotation.dart';

part 'cart_body.g.dart';

@JsonSerializable()
class CartBody {
  @JsonKey(name: 'courseShema')
  String? courseShema;

  @JsonKey(name: 'userShema')
  String? userShema;

  CartBody();

  factory CartBody.fromJson(Map<String, dynamic> json) => _$CartBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CartBodyToJson(this);
}
