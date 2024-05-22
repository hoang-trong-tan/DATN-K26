import 'package:flutter/material.dart';
import 'package:kltn/src/page/detail_course/detail_course_page.dart';
import 'package:kltn/src/page/main/widget/dialog_login.dart';
import 'package:kltn/src/page/notification/notification_page.dart';
import 'package:kltn/src/utils/app_colors.dart';

import '../../base/base_page.dart';
import 'main_vm.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget with MixinBasePage<MainBoardVM> {
  MainPage({super.key, this.initPage = 0, this.login});
  final int initPage;
  final Map<String, dynamic>? login;

  @override
  Widget build(BuildContext context) {
    return builder(
      () => Builder(builder: (context) {
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: IndexedStack(
            index: provider.currentIndex,
            children: [
              provider.home,
              provider.myCourse,
              provider.bookMark,
              provider.profile,
            ],
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,

            color: Colors.amber,
            // padding: EdgeInsets.zero,
            notchMargin: 6,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: provider.currentIndex,
              backgroundColor: Colors.white,
              showSelectedLabels: false,
              useLegacyColorScheme: false,
              showUnselectedLabels: false,
              elevation: 0,
              onTap: (index) {
                if (index == 1 && !provider.isLogin) {
                  showDialog(
                    context: context,
                    builder: (ctx) => const DialogLogin(
                      login: {'profile': 1},
                    ),
                  );
                  return;
                } else if (index == 2 && !provider.isLogin) {
                  showDialog(
                    context: context,
                    builder: (ctx) => const DialogLogin(
                      login: {'profile': 2},
                    ),
                  );
                  return;
                } else if (index == 3 && !provider.isLogin) {
                  showDialog(
                    context: context,
                    builder: (ctx) => const DialogLogin(
                      login: {'profile': 3},
                    ),
                  );
                  return;
                }
                provider.changePage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: AppColors.grayA2,
                    size: 20,
                  ),
                  label: '',
                  activeIcon: Icon(
                    Icons.home,
                    size: 20,
                    color: AppColors.blue_246BFD,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu_book_outlined,
                    color: AppColors.grayA2,
                    size: 20,
                  ),
                  label: '',
                  activeIcon: Icon(
                    Icons.menu_book_outlined,
                    color: AppColors.blue_246BFD,
                    size: 20,
                  ),
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     Icons.home,
                //     color: Colors.transparent,
                //   ),
                //   label: '',
                //   activeIcon: Icon(Icons.home, color: Colors.amber),
                // ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.book_rounded,
                    color: AppColors.grayA2,
                    size: 20,
                  ),
                  label: '',
                  activeIcon: Icon(
                    Icons.book_rounded,
                    color: AppColors.blue_246BFD,
                    size: 20,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: AppColors.grayA2,
                    size: 23,
                  ),
                  label: '',
                  activeIcon: Icon(
                    Icons.person,
                    color: AppColors.blue_246BFD,
                    size: 23,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  MainBoardVM create() => MainBoardVM();

  @override
  void initialise(BuildContext context) {
    provider.changePage(initPage);
    if (login?['cart'] != null && login?['home'] == null) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailCoursePage(id: login?['id_course'], login: login),
            ),
          );
        },
      );
    } else if (login?['cart'] != null && login?['home'] != null) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          provider.addCart(login?['id_course']);
        },
      );
    } else {
      if (login?['id_course'] != null) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailCoursePage(id: login?['id_course'], checkPay: true),
              ),
            );
          },
        );
        return;
      }
      if (login?['notification'] != null) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationPage(),
              ),
            );
          },
        );
      }
    }
  }
}
