import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/auth/otp_sign_up/otp_sign_up_vm.dart';
import 'package:kltn/src/page/auth/sign_in/sign_in_page.dart';
import 'package:kltn/src/page/auth/widget/input_otp.dart';

import '../../../utils/app_colors.dart';

class OtpSignUpPage extends StatefulWidget {
  const OtpSignUpPage({
    super.key,
    required this.email,
    required this.token,
    required this.name,
    required this.passwork,
  });
  final String email;
  final String token;
  final String name;
  final String passwork;

  @override
  State<OtpSignUpPage> createState() => _OtpSignUpState();
}

class _OtpSignUpState extends State<OtpSignUpPage> with MixinBasePage<OtpSignUpVM> {
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
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 6),
            child: const Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, top: 50),
          child: Column(children: [
            const Text(
              'Xác thực OTP',
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
              'Mã otp đã gửi đến email',
              style: TextStyle(
                color: AppColors.grayA2,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            Text(
              widget.email,
              style: const TextStyle(
                color: AppColors.blue_246BFD,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InputOtpWidget(
                    controller: provider.controller1,
                    autoFocus: true,
                    textInputType: TextInputType.number,
                    validate: (p0) {
                      if (p0!.length == 1) {
                        setState(() {
                          provider.checkOtp1 = true;
                          FocusScope.of(context).nextFocus();
                        });
                      } else {
                        provider.checkOtp1 = false;
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InputOtpWidget(
                    controller: provider.controller2,
                    autoFocus: false,
                    textInputType: TextInputType.number,
                    validate: (p0) {
                      if (p0!.length == 1) {
                        setState(() {
                          provider.checkOtp2 = true;
                          FocusScope.of(context).nextFocus();
                        });
                      } else {
                        provider.checkOtp2 = false;
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InputOtpWidget(
                    controller: provider.controller3,
                    autoFocus: false,
                    textInputType: TextInputType.number,
                    validate: (p0) {
                      if (p0!.length == 1) {
                        setState(() {
                          provider.checkOtp3 = true;
                          FocusScope.of(context).nextFocus();
                        });
                      } else {
                        provider.checkOtp3 = false;
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: InputOtpWidget(
                    controller: provider.controller4,
                    autoFocus: false,
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    validate: (p0) {
                      if (p0!.length == 1) {
                        setState(() {
                          provider.checkOtp4 = true;
                        });
                      } else {
                        provider.checkOtp4 = false;
                        FocusScope.of(context).previousFocus();
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bạn chưa nhận được mã OTP ',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                provider.remainingSeconds == 0
                    ? GestureDetector(
                        onTap: () {
                          provider.remainingSeconds = 90;
                          provider.countDown();
                          provider.reSendOtp(context);
                        },
                        child: const Text(
                          'Gửi lại',
                          style: TextStyle(
                            color: AppColors.blue_246BFD,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : Text(
                        provider.time,
                        style: const TextStyle(
                          color: AppColors.blue_246BFD,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            GestureDetector(
              onTap: provider.checkOtp1 && provider.checkOtp2 && provider.checkOtp3 && provider.checkOtp4
                  ? () {
                      provider.postOtp(context);
                    }
                  : () {},
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: provider.checkOtp1 && provider.checkOtp2 && provider.checkOtp3 && provider.checkOtp4
                      ? AppColors.blue_246BFD
                      : AppColors.grayA2,
                ),
                child: const Center(
                  child: Text('Gửi', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  OtpSignUpVM create() {
    return OtpSignUpVM();
  }

  @override
  void initialise(BuildContext context) {
    provider.token = widget.token;
    provider.name = widget.name;
    provider.passwork = widget.passwork;
    provider.email = widget.email;
    provider.callback = (e) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInPage(),
        ),
        (route) => false,
      );
      // SuccesPopup.show(context,'Đăng ký thành công');
      // Fluttertoast.showToast(
      //       msg: 'Đăng ký thành công',
      //       toastLength: Toast.LENGTH_SHORT,
      //       gravity: ToastGravity.BOTTOM,
      //       timeInSecForIosWeb: 1,
      //       backgroundColor: Colors.white,
      //       textColor: AppColors.blue_246BFD,
      //       fontSize: 16.0,
      //     );
    };
  }
}
