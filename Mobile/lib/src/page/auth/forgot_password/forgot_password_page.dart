import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/auth/forgot_password/forgot_password_vm.dart';

import '../../../utils/app_colors.dart';
import '../otp_sign_up/otp_sign_up.dart';
import '../widget/input.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage>
    with MixinBasePage<ForgotPasswordVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(children: [
              Stack(
                children: [
                  Image.asset('assets/image/background_signin.png'),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 50),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border:
                              Border.all(color: AppColors.white, width: 0.5)),
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_rounded,
                            color: Colors.white,
                            size: 20,
                          )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    const Text(
                      'Bạn đã quên mật khẩu???',
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
                      'Vui lòng nhập thông tin dưới đây để tạo mật khẩu mới',
                      style: TextStyle(
                        color: AppColors.grayA2,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    InputWidget(
                      lable: 'Email',
                      hintText: 'Nhập email...',
                      controller: provider.emailController,
                      textInputType: TextInputType.emailAddress,
                      validate: (p0) {
                        final emailRegExp =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (p0!.trim().isEmpty ||
                            provider.emailController.text.isEmpty) {
                          setState(() {
                            provider.checkEmail = false;
                            provider.checkValidateEmail = 'Vui lòng nhập Email';
                          });
                        } else if (!emailRegExp.hasMatch(p0)) {
                          setState(() {
                            provider.checkEmail = false;
                            provider.checkValidateEmail = 'Email không hợp lệ';
                          });
                        } else {
                          setState(() {
                            provider.checkEmail = true;
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
                      lable: 'Mật khẩu mới',
                      hintText: 'Nhập mật khẩu mới ...',
                      controller: provider.passwordController,
                      checkPassword: true,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          setState(() {
                            provider.checkPassword = false;
                            provider.checkValidatePassword =
                                'Vui lòng nhập mật khẩu';
                          });
                        } else if (p0.length < 6) {
                          setState(() {
                            provider.checkPassword = false;
                            provider.checkValidatePassword =
                                'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
                          });
                        } else {
                          setState(() {
                            provider.checkPassword = true;
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
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.red),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InputWidget(
                      lable: 'Xác nhận mật khẩu',
                      hintText: ' Xác nhân mật khẩu...',
                      controller: provider.confirmPasswordController,
                      checkPassword: true,
                      textInputAction: TextInputAction.done,
                      validate: (p0) {
                        if (p0!.isEmpty) {
                          setState(() {
                            provider.checkConfirmPassword = false;
                            provider.checkValidateConfirmPassword =
                                'Vui lòng nhập mật khẩu';
                          });
                        } else if (p0 != provider.passwordController.text) {
                          setState(() {
                            provider.checkConfirmPassword = false;
                            provider.checkValidateConfirmPassword =
                                'Mật khẩu không trùng khớp';
                          });
                        } else {
                          setState(() {
                            provider.checkConfirmPassword = true;
                            provider.checkValidateConfirmPassword = '';
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
                        provider.checkValidateConfirmPassword,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: provider.checkEmail &&
                              provider.checkPassword &&
                              provider.checkConfirmPassword
                          ? () {
                              // provider.savaAccount();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpSignUpPage(
                                      email: provider.emailController.text,token: '', name: '', passwork: '',),
                                ),
                              );
                            }
                          : () {},
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: provider.checkEmail &&
                                  provider.checkPassword &&
                                  provider.checkConfirmPassword
                              ? AppColors.blue_246BFD
                              : AppColors.grayA2,
                        ),
                        child: const Center(
                          child: Text('Đăng ký',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  @override
  ForgotPasswordVM create() {
    return ForgotPasswordVM();
  }

  @override
  void initialise(BuildContext context) {}
}
