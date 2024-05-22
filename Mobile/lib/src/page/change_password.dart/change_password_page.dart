import 'package:flutter/material.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/change_password.dart/change_password_vm.dart';
import 'package:kltn/src/page/change_password.dart/widget/item_textfield_widget.dart';
import 'package:kltn/src/utils/app_colors.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> with MixinBasePage<ChangePasswordVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40), border: Border.all(color: AppColors.gray99, width: 0.5)),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.black,
                        size: 20,
                      )),
                ),
              ],
            ),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 5),
            child: const Text(
              'Đổi mật khẩu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ItemTextFieldWidget(
              lable: 'Mật khẩu hiện tại',
              hintText: 'Nhập mật khẩu hiện tại',
              controller: provider.currentPasswordController,
              validate: (p0) {
                if (p0!.isEmpty) {
                  setState(() {
                    provider.checkCurentpassword = 'Vui lòng nhập mật khẩu';
                    provider.checkCurenPassword = false;
                  });
                } else if (p0.length < 6) {
                  setState(() {
                    provider.checkCurentpassword = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
                    provider.checkCurenPassword = false;
                  });
                } else {
                  setState(() {
                    provider.checkCurenPassword = true;
                    provider.checkCurentpassword = '';
                  });
                }
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              provider.checkCurentpassword,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
            ),
            const SizedBox(
              height: 5,
            ),
            ItemTextFieldWidget(
              lable: 'Mật khẩu mới',
              hintText: 'Nhập mật khẩu mới',
              controller: provider.newPasswordController,
              validate: (p0) {
                if (p0!.isEmpty) {
                  setState(() {
                    provider.checkNewPassword = false;
                    provider.checknewpassword = 'Vui lòng nhập mật khẩu';
                  });
                } else if (p0.length < 6) {
                  setState(() {
                    provider.checkNewPassword = false;
                    provider.checknewpassword = 'Vui lòng nhập mật khẩu lớn hơn 6 ký tự';
                  });
                } else {
                  setState(() {
                    provider.checkNewPassword = true;
                    provider.checknewpassword = '';
                  });
                }
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              provider.checknewpassword,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
            ),
            const SizedBox(
              height: 5,
            ),
            ItemTextFieldWidget(
              lable: 'Xác nhận mật khẩu',
              hintText: 'Xác nhận mật khẩu mới',
              controller: provider.confirmNewPasswordController,
              validate: (p0) {
                if (p0 != provider.newPasswordController.text) {
                  setState(() {
                    provider.checkConfirmPassword = false;
                    provider.checkconfirmpassword = 'Mật khẩu không trùng khớp';
                  });
                } else {
                  setState(() {
                    provider.checkConfirmPassword = true;
                    provider.checkconfirmpassword = '';
                  });
                }
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              provider.checkconfirmpassword,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.red),
            ),
            const SizedBox(
              height: 5,
            ),
          ]),
        ),
        bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            // height: 100,
            // color: Colors.amber,

            child: GestureDetector(
              onTap: provider.checkCurenPassword && provider.checkNewPassword && provider.checkConfirmPassword
                  ? () {
                      provider.changePassword();
                    }
                  : () {},
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: provider.checkNewPassword && provider.checkCurenPassword && provider.checkConfirmPassword
                      ? AppColors.blue_246BFD
                      : AppColors.grayA2,
                ),
                child: const Center(
                  child: Text('Đổi mật khẩu',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                ),
              ),
            )),
      ),
    );
  }

  @override
  ChangePasswordVM create() {
    return ChangePasswordVM();
  }

  @override
  void initialise(BuildContext context) {
    provider.callback = (e) {
      if (e == true) {
        Navigator.pop(context);
      }
    };
  }
}
