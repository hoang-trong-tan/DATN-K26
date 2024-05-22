import 'package:dio/dio.dart';
import 'package:kltn/src/remote/service/body/otp_body.dart';
import 'package:kltn/src/remote/service/body/sigin_body.dart';
import 'package:kltn/src/remote/service/respone/auth/otp_respone.dart';
import 'package:kltn/src/remote/service/respone/auth/signin_response.dart';
import 'package:kltn/src/remote/service/respone/auth/signup_respone.dart';
import 'package:retrofit/http.dart';


import 'body/signup_body.dart';
import 'respone/base_auth_response.dart';

part 'auth_service.g.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  // đăng ký
  @POST('/user/signup') //dường dẫn sever
  Future<BaseAuthResponse<SignupRespone>> postSignup(@Body() SignupBody body );

  // đăng ký
  @POST('/user/activate-user') //dường dẫn sever
  Future<BaseAuthResponse<OtpRespone>> postActivateUser(@Body() OtpBody body );

  // đăng nhập
  @POST('/user/login') //dường dẫn sever
  Future<BaseAuthResponse<SigninRespone>> postSignin(@Body() SigninBody body );

}
