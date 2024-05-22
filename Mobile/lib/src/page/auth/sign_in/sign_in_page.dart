import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/auth/sign_in/sign_in_vm.dart';
import 'package:kltn/src/page/auth/sign_up/sign_up_page.dart';
import 'package:kltn/src/page/auth/widget/input.dart';
import 'package:kltn/src/page/main/main_page.dart';
import 'package:kltn/src/utils/app_colors.dart';

import '../update_imformation_teacher/update_imformation_teacher_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key, this.checkLogin});
  final Map<String, dynamic>? checkLogin;

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with MixinBasePage<SignInVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Center(
              child: Column(children: [
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 185,
                    child: Image.asset(
                      'assets/image/background_signin.png',
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Chào mừng bạn đã trở lại với K26-Demy',
                        style: TextStyle(
                          color: AppColors.grayA2,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 70,
                      ),
                      InputWidget(
                        lable: 'Email',
                        hintText: 'Nhập email...',
                        controller: provider.emailController,
                        textInputType: TextInputType.emailAddress,
                        validate: (p0) {
                          final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (p0!.trim().isEmpty || provider.emailController.text.isEmpty) {
                            setState(() {
                              provider.checkValidateEmail = 'Vui lòng nhập Email';
                            });
                          } else if (!emailRegExp.hasMatch(p0)) {
                            setState(() {
                              provider.checkValidateEmail = 'Email không hợp lệ';
                            });
                          } else {
                            setState(() {
                              provider.checkValidateEmail = '';
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          provider.checkValidateEmail,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      InputWidget(
                        lable: 'Mật khẩu',
                        hintText: 'Nhập mật khẩu...',
                        controller: provider.passwordController,
                        checkPassword: true,
                        textInputAction: TextInputAction.done,
                        validate: (p0) {
                          if (p0!.isEmpty) {
                            setState(() {
                              provider.checkValidatePassword = 'Vui lòng nhập mật khẩu';
                            });
                          } else if (p0.length < 6) {
                            setState(() {
                              provider.checkValidatePassword = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
                            });
                          } else {
                            setState(() {
                              provider.checkValidatePassword = '';
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          provider.checkValidatePassword,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      Row(
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Checkbox(
                              value: provider.checkSaveAccount,
                              checkColor: AppColors.blue_246BFD,
                              activeColor: AppColors.white,
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                  color: AppColors.blue_246BFD,
                                  width: 1.5,
                                ),
                              ),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
                              onChanged: (value) {
                                setState(() {
                                  provider.checkSaveAccount = value ?? false;
                                });
                              },
                            ),
                          ),
                          const Text(
                            'Ghi nhớ tài khoản',
                            style: TextStyle(
                              color: AppColors.grayA2,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                          ),
                          // const Spacer(),
                          // GestureDetector(
                          //   onTap: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => const ForgotPasswordPage(),
                          //       ),
                          //     );
                          //   },
                          //   child: const Text(
                          //     'Quên mật khẩu?',
                          //     style: TextStyle(
                          //       color: AppColors.blue_246BFD,
                          //       fontWeight: FontWeight.w600,
                          //       decoration: TextDecoration.underline,
                          //       fontSize: 14,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          provider.savaAccount();
                          provider.postSignin(context);
                        },
                        child: Container(
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: AppColors.blue_246BFD,
                          ),
                          child: const Center(
                            child: Text('Đăng nhập',
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 150,
                      ),
                      // const Row(
                      //   children: [
                      //     SizedBox(
                      //       width: 30,
                      //     ),
                      //     Expanded(
                      //       child: SizedBox(
                      //         width: 100,
                      //         child: Divider(
                      //           color: AppColors.h9497AD,
                      //           height: 0,
                      //         ),
                      //       ),
                      //     ),
                      //     Text(
                      //       ' Đăng nhập bằng ',
                      //       style: TextStyle(color: AppColors.grayA2, fontSize: 14, fontWeight: FontWeight.w400),
                      //     ),
                      //     Expanded(
                      //       child: SizedBox(
                      //         width: 100,
                      //         child: Divider(
                      //           color: AppColors.h9497AD,
                      //           height: 0,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 30,
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // Container(
                      //   width: 50,
                      //   height: 50,
                      //   padding: const EdgeInsets.all(10),
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(40),
                      //       border: Border.all(color: AppColors.gray99, width: 0.5)),
                      //   child: SvgPicture.asset('assets/icon/google.svg'),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Bạn chưa có tài khoản? ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ));
                            },
                            child: const Text(
                              'Đăng ký ngay',
                              style: TextStyle(
                                color: AppColors.blue_246BFD,
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  SignInVM create() {
    return SignInVM();
  }

  @override
  void initialise(BuildContext context) {
    provider.login = widget.checkLogin ?? {};
    provider.callback = (p0) {
      if (provider.model.userRole == 'teacher' && (provider.model.userExperience ?? []).isEmpty) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => UpdateImformationTeacherpage(checkLogin: widget.checkLogin ?? {}),
          ),
          (route) => false,
        );
      } else {
        provider.prefs.userUpdate = true;
        if (widget.checkLogin?['profile'] != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(initPage: widget.checkLogin?['profile']),
            ),
            (route) => false,
          );
        } else if (widget.checkLogin?['id_course'] != null || widget.checkLogin?['notification'] != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(login: widget.checkLogin),
            ),
            (route) => false,
          );
        } else {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ),
            (route) => false,
          );
        }
      }
    };
  }
}
