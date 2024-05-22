import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';
import '../../auth/sign_in/sign_in_page.dart';
import '../../profile/widgets/dialog_widget.dart';

class DialogLogin extends StatelessWidget {
  const DialogLogin({super.key,this.login});
  final Map<String, dynamic>? login;

  @override
  Widget build(BuildContext context) {
    return PlaceholderDialog(
      icon: Icon(
        Icons.login,
        color: Colors.blue[700],
        size: 80.0,
      ),
      title: 'Đăng nhập',
      message: 'Vui lòng đăng nhập để sử dụng tính năng này',
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.gray99,
                    ),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Trở về',
                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  SignInPage(checkLogin: login),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.blue_246BFD,
                    ),
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text('Đăng nhập',
                            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
