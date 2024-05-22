import 'package:json_annotation/json_annotation.dart';

part 'quiz_title_model.g.dart';

@JsonSerializable()
class QuizTitleModel {
  @JsonKey(name: '_id')
  String? id;

  @JsonKey(name: 'quiz_Tile')
  String? quizTile;

  QuizTitleModel();

  factory QuizTitleModel.fromJson(Map<String, dynamic> json) => _$QuizTitleModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizTitleModelToJson(this);
}