import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/base/helper/helper.dart';
import 'package:kltn/src/model/user_model.dart';
import 'package:kltn/src/page/auth/sign_in/sign_in_page.dart';
import 'package:kltn/src/page/change_password.dart/change_password_page.dart';
import 'package:kltn/src/page/profile/profile_vm.dart';
import 'package:kltn/src/page/profile/widgets/item_profile.dart';
import 'package:kltn/src/page/your_profile/your_profile_page.dart';
import 'package:kltn/src/utils/app_colors.dart';

import '../dashboard_tearcher/dashboard_tearcher_page.dart';
import 'widgets/dialog_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with MixinBasePage<ProfileVM> {
  @override
  Widget build(BuildContext context) {
    return builder(
      () => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        // padding: const EdgeInsets.only(top: 100),
                        decoration: const BoxDecoration(
                          color: AppColors.blue_246BFD,
                          // borderRadius: BorderRadius.only(
                          //     bottomLeft: Radius.circular(50),
                          //     bottomRight: Radius.circular(50)),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 200),
                          child: Stack(
                            children: [
                              // Container(
                              //   width: 100,
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //     borderRadius: BorderRadius.circular(50),
                              //     border:
                              //         Border.all(color: Colors.amber, width: 2),
                              //     image: const DecorationImage(
                              //       image: NetworkImage(
                              //           'https://th.bing.com/th/id/OIP._wQ5Yn7Oy_1MzUVTUTa-hgHaEK?rs=1&pid=ImgDetMain'),
                              //       fit: BoxFit.cover,
                              //     ),
                              //   ),
                              // ),
                              Container(
                                width: 100,
                                height: 100,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                  border: Border.all(color: Colors.amber, width: 2),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: provider.avatar.isEmpty
                                      ? Image.asset(
                                          'assets/image/logo.png',
                                          fit: BoxFit.contain,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl: provider.avatar,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                ),
                              ),

                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const YourProfilePage(),
                                        )).then((value) {
                                      if (value is UserModel) {
                                        setState(() {
                                          provider.name = value.userName ?? '';
                                          provider.avatar = value.userAvatar ?? '';
                                        });
                                      }
                                    });
                                  },
                                  child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: AppColors.blue_246BFD,
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Colors.white, width: 1)),
                                      child: const Icon(
                                        Icons.mode_edit_outline_outlined,
                                        color: Colors.white,
                                        size: 15,
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    provider.name,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 70,
                  // ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              ItemProfileWidget(
                icon: Icons.person_outline,
                title: 'Thông tin của bạn',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const YourProfilePage(),
                    ),
                  ).then((value) {
                    if (value is UserModel) {
                      setState(() {
                        provider.name = value.userName ?? '';
                        provider.avatar = value.userAvatar ?? '';
                      });
                    }
                  });
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Visibility(
                visible: provider.prefs.userRole == 'teacher',
                child: Column(
                  children: [
                    ItemProfileWidget(
                      icon: Icons.dashboard,
                      title: 'Thông số khóa học ',
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashBoardTearcherPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              ItemProfileWidget(
                icon: Icons.key,
                title: 'Đổi mật khẩu',
                ontap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ItemProfileWidget(
                icon: Icons.lock_outlined,
                title: 'Chính sách bảo mật',
                ontap: () {
                  Helper.openBrowser('https://s.pro.vn/QXOW');
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ItemProfileWidget(
                icon: Icons.help_outline_rounded,
                title: 'Trung tâm trợ giúp',
                ontap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: const OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(30),
                        right: Radius.circular(30),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        height: 200,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(30),
                            right: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Trung tâm trợ giúp',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  provider.launchUrlFace('https://www.facebook.com/dangson13.04.02');
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icon/facebook.svg',
                                      height: 70,
                                      width: 70,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Facebook',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  provider.launchURLEmail();
                                  Navigator.pop(context);
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icon/gmail.svg',
                                      height: 70,
                                      width: 70,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      'Gmail',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ]),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              ItemProfileWidget(
                icon: Icons.login_outlined,
                title: 'Đăng xuất',
                divider: false,
                ontap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => PlaceholderDialog(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 80.0,
                      ),
                      title: 'Đăng xuất',
                      message: 'Bạn có muốn đăng xuất tài khoản?',
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
                                        child: Text('Trở về',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    provider.removeToken();
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const SignInPage(),
                                        ),
                                        (route) => false);
                                  },
                                  child: Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: AppColors.blue_246BFD,
                                    ),
                                    child: const Align(
                                        alignment: Alignment.center,
                                        child: Text('Đăng xuất',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400))),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  ProfileVM create() {
    return ProfileVM();
  }

  @override
  void initialise(BuildContext context) {}
}
