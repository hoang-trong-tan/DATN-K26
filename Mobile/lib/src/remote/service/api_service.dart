import 'package:dio/dio.dart';
import 'package:kltn/src/remote/service/body/answer_body.dart';
import 'package:kltn/src/remote/service/body/profile_body.dart';
import 'package:kltn/src/remote/service/body/question_body.dart';
import 'package:kltn/src/remote/service/body/reply_body.dart';
import 'package:kltn/src/remote/service/body/review_body.dart';
import 'package:kltn/src/remote/service/body/update_imformation_body.dart';
import 'package:kltn/src/remote/service/respone/answer_and_question/answer_and_question_response.dart';
import 'package:kltn/src/remote/service/respone/mentor/mentor_response.dart';
import 'package:kltn/src/remote/service/respone/review/review_response.dart';
import 'package:kltn/src/remote/service/respone/vnpay/vnpay_response.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

import 'package:kltn/src/model/course_type_model.dart';
import 'package:kltn/src/remote/service/respone/base_response.dart';

import '../../model/course_detail_model.dart';
import '../../model/course_intro_model.dart';
import '../../model/course_shema_model.dart';
import '../../model/user_model.dart';
import 'body/quiz_body.dart';
import 'body/update_password_body.dart';
import 'respone/base_list_response.dart';
import 'respone/cart/cart_response.dart';
import 'respone/course_process/course_process_response.dart';
import 'respone/notification/notification_response.dart';
import 'respone/photo_response.dart';
import 'respone/quiz/quiz_answer/quiz_answer_response.dart';
import 'respone/quiz/quiz_response.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // lấy khóa học chi tiết chưa đăng nhập
  @GET('/course/get-one-course/{id}')
  Future<BaseResponse<DeatilCouseRespone>> getCourseNoLogin(
    @Path('id') String? id,
  );
  // lấy khóa học chi tiết đã đăng nhập
  @GET('/course/get-one-course/learn/{id}')
  Future<BaseResponse<DeatilCouseRespone>> getCourse(
      @Path('id') String? id,
      @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser);

  //lấy loại khóa học
  @GET('/course/get-all-course-type') //dường dẫn sever
  Future<BaseListResponse<CourseTypeModel>> getCourseType();

  //lấy khóa học theo loại
  @GET('/course/get-course-by-type/{id}')
  Future<BaseListResponse<CourseIntroModel>> getAllCourseToType(
      @Path('id') String? id, @Query('limit') int? limit, @Query('page') int? page, @Body() Map<String, dynamic> body);

  //search course
  @GET('/course/search')
  Future<BaseListResponse<CourseIntroModel>> getSearch(@Query('keySearch') String? search, @Query('type') String? type,
      @Query('limit') int? limit, @Query('page') int? page);

  //user
  @GET('/course/search')
  Future<BaseListResponse<UserModel>> getSearchUser(@Query('keySearch') String? search, @Query('type') String? type,
      @Query('limit') int? limit, @Query('page') int? page);

  // post cart
  @POST('/cart')
  Future<BaseResponse<CourseShemaModel>> postCart(
    @Path('id') String? id,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // get cart
  @GET('/cart/{id}')
  Future<BaseListResponse<CartResponse>> getCart(
    @Path('id') String? id,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // xóa cart
  @DELETE('/cart/{id}')
  Future<BaseListResponse<CartResponse>> deleteCart(
    @Path('id') String? id,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // vnpay
  @POST('/create-order/payment/create_payment_url/{id}')
  Future<VnpayRespone> payCourse(
    @Path('id') String? idUser,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // tạo review
  @POST('/feedback/review/{id}')
  Future<BaseResponse> createReview(
      @Path('id') String? id,
      @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
      @Body() ReviewBody? body);

  // reply review
  @POST('/feedback/reply-review/{id}')
  Future<BaseResponse> createReplyComent(
      @Path('id') String? idComment,
      @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
      @Body() ReplyCommentBody? body);

  // get review
  @GET('/feedback/get-review/{id}')
  Future<BaseListResponse<ReviewResponse>> getReview(
      @Path('id') String? id, @Query('limit') int? limit, @Query('page') int? page);

  // tạo câu hỏi
  @POST('/feedback/add-question/{id}')
  Future<BaseResponse> createQuestion(
      @Path('id') String? idVideo,
      @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
      @Body() QuestionBody? body);

  // tạo câu trả lời
  @POST('/feedback/add-anwser/{id}')
  Future<BaseResponse> createAnwser(
      @Path('id') String? idComment,
      @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
      @Body() AnwserBody? body);

  // get question and anwser
  @GET('/feedback/get-question/{id}')
  Future<BaseListResponse<AnswerAndQuestionRespone>> getQuestionAndAnwser(
      @Path('id') String? idVideo,
      @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
      @Query('limit') int? limit,
      @Query('page') int? page);

  // get question quiz
  @GET('/quiz/get-question-quiz/{id}')
  Future<BaseListResponse<QuizResponse>> getQuestionQuiz(
    @Path('id') String? idQuiz,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // get question and answer quiz
  @GET('/quiz/show-answer-quiz/{id}')
  Future<BaseResponse<QuizAnswerResponse>> getQuestionAndAnswerQuiz(
    @Path('id') String? idQuiz,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // tạo câu trả lời
  @POST('/quiz/submit-quiz/{id}')
  Future<BaseResponse> createAnwserQuiz(
      @Path('id') String? idQuiz,
      @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
      @Body() List<QuizBody>? body);

  // Get thong tin giảng viên
  @GET('/user/information-teacher/{id}')
  Future<BaseResponse<MentorResponse>> getInforMentor(
    @Path('id') String? idMentor,
  );

  // Get khóa học bán chạy
  @GET('/course/get-all-course')
  Future<BaseListResponse<CourseShemaModel>> getpopularCourse(
      @Query('limit') int? limit, @Query('page') int? page, @Body() Map<String, dynamic> body);

  // get qua hoc giang vien
  @GET('/user/all-course-teacher/{id}')
  Future<BaseListResponse<CourseIntroModel>> getCourseMentor(
      @Path('id') String? idMentor, @Query('limit') int? limit, @Query('page') int? page);

  // get user
  @GET('/user/information')
  Future<BaseResponse<UserModel>> getUser(
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // upload images
  @POST('/upload-images')
  Future<PhotoResponse> uploadImage(@retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser, @Body() FormData body);

  // update profile
  @PATCH('/user/update-profile')
  Future<BaseResponse<UserModel>> updateProfile(@retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser, @Body() ProfileBody body);

  // update profile
  @PATCH('/user/update-profile')
  Future<BaseResponse<UserModel>> updateImformation(@retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser, @Body() UpdateImfomationBody body);
  // update fcm
  @PATCH('/user/update-profile')
  Future<BaseResponse<UserModel>> updateFcm(@retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser, @Body() Map<String,dynamic> body);
  // update profile
  @PATCH('/user/update-password')
  Future<BaseResponse<UserModel>> updatePassword(@retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser, @Body() UpdatePasswordBody body);

  // gửi video da xem
  @POST('/course/update-process-learn/{id}')
  Future<BaseResponse> postVideoView(
      @Path('id') String? idCourse,
      @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
      @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
      @Body() Map<String, String> body);

  // get tiến trình
  @GET('/user/get-purchased-course')
  Future<BaseResponse<CourseProcessResponse>> getCourseProcess(
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // get all giảng viên
  @GET('/course/get-all-teacher')
  Future<BaseListResponse<UserModel>> getAllTearcher(@Query('limit') int? limit, @Query('page') int? page);

  // get tai lieu
  @GET('/get-document/{id}')
  Future<BaseListResponse<String>> getAllDocument(
    @Path('id') String idVideo,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // download tai lieu
  @GET('/download-document/{id}')
  Future<BaseListResponse<String>> downloadDocument(
    @Path('id') String idVideo,
    @Query('fileName') String? fileName,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );

  // thong bao
  @GET('/notification/get-notifications?filter')
  Future<BaseResponse<NotificationResponse>> getNotification(
    @Path('filter') String? filter,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );
  
  // thong bao
  @GET('/course/get-one-video/{id}')
  Future<BaseResponse<CourseDetailModel>> getVideo(
    @Path('id') String? idVideo,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );
  
  // post thong bao da xem
  @PATCH('/notification/update-notification/{id}')
  Future<BaseResponse> readNotication(
    @Path('id') String idNotification,
    @retrofit.Headers({'x-atoken-id': ''}) Map<String, dynamic> headers,
    @retrofit.Headers({'x-client-id': ''}) Map<String, dynamic> headersIdUser,
  );
}
