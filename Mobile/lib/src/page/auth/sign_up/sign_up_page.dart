import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/auth/otp_sign_up/otp_sign_up.dart';
import 'package:kltn/src/page/auth/sign_in/sign_in_page.dart';
import 'package:kltn/src/page/auth/sign_up/sign_up_vm.dart';
import 'package:kltn/src/page/auth/widget/input.dart';
import 'package:kltn/src/utils/app_colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with MixinBasePage<SignUpVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        appBar: AppBar(
          // toolbarHeight: 80,
          backgroundColor: AppColors.blue_246BFD,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), border: Border.all(color: AppColors.white, width: 0.5)),
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
              ],
            ),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
            child: const Text(
              'Đăng ký tài khoản',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
              child: Column(children: [
                const Text(
                  'Tạo tài khoản mới',
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
                  'Vui lòng nhập tất cả thông tin phía dưới',
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
                  lable: 'Họ và Tên',
                  hintText: 'Nhập họ và tên',
                  controller: provider.nameController,
                  validate: (p0) {
                    if (p0!.trim().isEmpty) {
                      setState(() {
                        provider.checkName = false;
                        provider.checkValidateName = 'Vui lòng nhập họ và tên';
                      });
                    } else {
                      setState(() {
                        provider.checkName = true;
                        provider.checkValidateName = '';
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
                    provider.checkValidateName,
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
                  lable: 'Email',
                  hintText: 'Nhập email...',
                  controller: provider.emailController,
                  textInputType: TextInputType.emailAddress,
                  validate: (p0) {
                    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (p0!.trim().isEmpty || provider.emailController.text.isEmpty) {
                      setState(() {
                        provider.checkEmail = false;
                        provider.checkValidateEmail = 'Vui lòng nhập Email';
                      });
                    } else if (!emailRegExp.hasMatch(p0)) {
                      setState(() {
                        provider.checkEmail = true;
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
                  lable: 'Mật khẩu',
                  hintText: 'Nhập mật khẩu...',
                  controller: provider.passwordController,
                  checkPassword: true,
                  validate: (p0) {
                    if (p0!.isEmpty) {
                      setState(() {
                        provider.checkPassword = false;
                        provider.checkValidatePassword = 'Vui lòng nhập mật khẩu';
                      });
                    } else if (p0.length < 6) {
                      setState(() {
                        provider.checkPassword = false;
                        provider.checkValidatePassword = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
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
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
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
                        provider.checkValidateConfirmPassword = 'Vui lòng nhập mật khẩu';
                      });
                    } else if (p0 != provider.passwordController.text) {
                      setState(() {
                        provider.checkConfirmPassword = false;
                        provider.checkValidateConfirmPassword = 'Mật khẩu không trùng khớp';
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
                Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Checkbox(
                        value: provider.checkUser,
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
                            provider.checkUser = value ?? false;
                          });
                        },
                      ),
                    ),
                    const Text(
                      'Đăng ký với giảng viên',
                      style: TextStyle(
                        color: AppColors.grayA2,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
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
                  onTap: provider.checkName &&
                          provider.checkEmail &&
                          provider.checkPassword &&
                          provider.checkConfirmPassword
                      ? () {
                          // provider.savaAccount();
                          provider.postSignup(context);
                        }
                      : () {},
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: provider.checkName &&
                              provider.checkEmail &&
                              provider.checkPassword &&
                              provider.checkConfirmPassword
                          ? AppColors.blue_246BFD
                          : AppColors.grayA2,
                    ),
                    child: const Center(
                      child: Text('Đăng ký',
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Bạn đã có tài khoản? ',
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
                              builder: (context) => const SignInPage(),
                            ));
                      },
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: AppColors.blue_246BFD,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  @override
  SignUpVM create() {
    return SignUpVM();
  }

  @override
  void initialise(BuildContext context) {
    provider.callback = (token) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpSignUpPage(
            email: provider.emailController.text,
            token: provider.token,
            name: provider.nameController.text,
            passwork: provider.confirmPasswordController.text,
          ),
        ),
      );
    };
  }
}
