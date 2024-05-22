import 'package:json_annotation/json_annotation.dart';

part 'answer_body.g.dart';

@JsonSerializable()
class AnwserBody {
  @JsonKey(name: 'answser_comment')
  String? answserComment;

  AnwserBody();

  factory AnwserBody.fromJson(Map<String, dynamic> json) => _$AnwserBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AnwserBodyToJson(this);
}
