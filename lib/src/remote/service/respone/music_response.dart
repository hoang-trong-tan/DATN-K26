import 'package:json_annotation/json_annotation.dart';


import '../../../model/music_model.dart';
import 'base_response.dart';


part 'music_response.g.dart';

@JsonSerializable()
class MusicResponse extends BaseResponse {
  @JsonKey(name: 'music')
  List<MusicModel>? dataList;

  MusicResponse();

  factory MusicResponse.fromJson(Map<String, dynamic> json) =>
      _$MusicResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MusicResponseToJson(this);
}
