// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BaseResponse<DeatilCouseRespone>> getCourse(
    String? id,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<DeatilCouseRespone>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/get-one-course/learn/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<DeatilCouseRespone>.fromJson(
      _result.data!,
      (json) => DeatilCouseRespone.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<DeatilCouseRespone>> getCourseNoLogin(
    String? id,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<DeatilCouseRespone>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/get-one-course/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<DeatilCouseRespone>.fromJson(
      _result.data!,
      (json) => DeatilCouseRespone.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<CourseTypeModel>> getCourseType() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<CourseTypeModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/get-all-course-type',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<CourseTypeModel>.fromJson(
      _result.data!,
      (json) => CourseTypeModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<CourseIntroModel>> getAllCourseToType(
      String? id, int? limit, int? page, Map<String, dynamic> body) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<CourseIntroModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/get-course-by-type/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<CourseIntroModel>.fromJson(
      _result.data!,
      (json) => CourseIntroModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<CourseIntroModel>> getSearch(
    String? search,
    String? type,
    int? limit,
    int? page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keySearch': search,
      r'type': type,
      r'limit': limit,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<CourseIntroModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/search',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<CourseIntroModel>.fromJson(
      _result.data!,
      (json) => CourseIntroModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<UserModel>> getSearchUser(
    String? search,
    String? type,
    int? limit,
    int? page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'keySearch': search,
      r'type': type,
      r'limit': limit,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<UserModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/search',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<UserModel>.fromJson(
      _result.data!,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<CourseShemaModel>> postCart(
    String? id,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    // _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<CourseShemaModel>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/cart/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<CourseShemaModel>.fromJson(
      _result.data!,
      (json) => CourseShemaModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<CartResponse>> getCart(
    String? id,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<CartResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/cart/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<CartResponse>.fromJson(
      _result.data!,
      (json) => CartResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<CartResponse>> deleteCart(
    String? id,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<CartResponse>>(Options(
      method: 'DELETE',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/cart/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<CartResponse>.fromJson(
      _result.data!,
      (json) => CartResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<VnpayRespone> payCourse(
    String? idUser,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<VnpayRespone>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/create-order/payment/create_payment_url/${idUser}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = VnpayRespone.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResponse<dynamic>> createReview(
    String? id,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    ReviewBody? body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/feedback/review/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<BaseResponse<dynamic>> createReplyComent(
    String? idComment,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    ReplyCommentBody? body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/feedback/reply-review/${idComment}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<BaseListResponse<ReviewResponse>> getReview(
    String? id,
    int? limit,
    int? page,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<ReviewResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/feedback/get-review/${id}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<ReviewResponse>.fromJson(
      _result.data!,
      (json) => ReviewResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<dynamic>> createQuestion(
    String? idVideo,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    QuestionBody? body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/feedback/add-question/${idVideo}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<BaseResponse<dynamic>> createAnwser(
    String? idComment,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    AnwserBody? body,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    _data.addAll(body?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/feedback/add-anwser/${idComment}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<BaseListResponse<AnswerAndQuestionRespone>> getQuestionAndAnwser(
    String? idVideo,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    int? limit,
    int? page,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result =
        await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<AnswerAndQuestionRespone>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/feedback/get-question/${idVideo}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = BaseListResponse<AnswerAndQuestionRespone>.fromJson(
      _result.data!,
      (json) => AnswerAndQuestionRespone.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<QuizResponse>> getQuestionQuiz(
    String? idQuiz,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<QuizResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/quiz/get-question-quiz/${idQuiz}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<QuizResponse>.fromJson(
      _result.data!,
      (json) => QuizResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<QuizAnswerResponse>> getQuestionAndAnswerQuiz(
    String? idQuiz,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<QuizAnswerResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/quiz/show-answer-quiz/${idQuiz}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<QuizAnswerResponse>.fromJson(
      _result.data!,
      (json) => QuizAnswerResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<dynamic>> createAnwserQuiz(
    String? idQuiz,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    List<QuizBody>? body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = body?.map((e) => e.toJson()).toList();
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/quiz/submit-quiz/${idQuiz}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<BaseResponse<MentorResponse>> getInforMentor(String? idMentor) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<MentorResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/information-teacher/${idMentor}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<MentorResponse>.fromJson(
      _result.data!,
      (json) => MentorResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<CourseShemaModel>> getpopularCourse(
    int? limit,
    int? page,
    Map<String, dynamic> body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<CourseShemaModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/get-all-course',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<CourseShemaModel>.fromJson(
      _result.data!,
      (json) => CourseShemaModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<CourseIntroModel>> getCourseMentor(
    String? idMentor,
    int? limit,
    int? page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<CourseIntroModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/all-course-teacher/${idMentor}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<CourseIntroModel>.fromJson(
      _result.data!,
      (json) => CourseIntroModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<UserModel>> getUser(
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<UserModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/information',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<UserModel>.fromJson(
      _result.data!,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<PhotoResponse> uploadImage(
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    FormData body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = body;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<PhotoResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/upload-images',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = PhotoResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResponse<UserModel>> updateProfile(
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    ProfileBody body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<UserModel>>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/update-profile',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<UserModel>.fromJson(
      _result.data!,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<UserModel>> updateImformation(
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    UpdateImfomationBody body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<UserModel>>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/update-profile',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<UserModel>.fromJson(
      _result.data!,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<UserModel>> updateFcm(
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    Map<String, dynamic> body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<UserModel>>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/update-profile',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<UserModel>.fromJson(
      _result.data!,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<UserModel>> updatePassword(
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    UpdatePasswordBody body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    _data.addAll(body.toJson());
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<UserModel>>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/update-password',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<UserModel>.fromJson(
      _result.data!,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<dynamic>> postVideoView(
    String? idCourse,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
    Map<String, String> body,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    final _data = <String, dynamic>{};
    _data.addAll(body);
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/update-process-learn/${idCourse}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  @override
  Future<BaseResponse<CourseProcessResponse>> getCourseProcess(
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<CourseProcessResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/user/get-purchased-course',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<CourseProcessResponse>.fromJson(
      _result.data!,
      (json) => CourseProcessResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<UserModel>> getAllTearcher(
    int? limit,
    int? page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'limit': limit,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<UserModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/get-all-teacher',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<UserModel>.fromJson(
      _result.data!,
      (json) => UserModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseListResponse<String>> getAllDocument(
    String idVideo,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<String>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/get-document/${idVideo}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<String>.fromJson(
      _result.data!,
      (json) => json as String,
    );
    return value;
  }

  @override
  Future<BaseListResponse<String>> downloadDocument(
    String idVideo,
    String? fileName,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'fileName': fileName};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseListResponse<String>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/download-document/${idVideo}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseListResponse<String>.fromJson(
      _result.data!,
      (json) => json as String,
    );
    return value;
  }

  @override
  Future<BaseResponse<NotificationResponse>> getNotification(
    String? filter,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<NotificationResponse>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/notification/get-notifications$filter',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<NotificationResponse>.fromJson(
      _result.data!,
      (json) => NotificationResponse.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }
  @override
  Future<BaseResponse<CourseDetailModel>> getVideo(
    String? id,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<CourseDetailModel>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/course/get-one-video/$id',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<CourseDetailModel>.fromJson(
      _result.data!,
      (json) => CourseDetailModel.fromJson(json as Map<String, dynamic>),
    );
    return value;
  }

  @override
  Future<BaseResponse<dynamic>> readNotication(
    String idNotification,
    Map<String, dynamic> headers,
    Map<String, dynamic> headersIdUser,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{
      'x-atoken-id': headers['x-atoken-id'],
      'x-client-id': headersIdUser['x-client-id']
    };
    const Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(_setStreamType<BaseResponse<dynamic>>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
        .compose(
          _dio.options,
          '/notification/update-notification/${idNotification}',
          queryParameters: queryParameters,
          data: _data,
        )
        .copyWith(
            baseUrl: _combineBaseUrls(
          _dio.options.baseUrl,
          baseUrl,
        ))));
    final value = BaseResponse<dynamic>.fromJson(
      _result.data!,
      (json) => json as dynamic,
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
