import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../../model/music_model.dart';
import 'respone/music_response.dart';


part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('uamp/catalog.json')//dường dẫn sever
  Future<MusicResponse> getMusic();

}