import 'package:flutter/material.dart';

import '../../base/base_page.dart';
import 'main_vm.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget with MixinBasePage<MainBoardVM> {
  MainPage({super.key, this.initPage = 0});

  final int initPage;

  @override
  Widget build(BuildContext context) {
    return builder(
      () => Builder(builder: (context) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: IndexedStack(
            index: provider.currentIndex,
            children: [
              provider.home,
              // provider.news,
              // provider.supportSOS,
              // provider.notification,
              // provider.setting,
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
              showUnselectedLabels: false,
              elevation: 0,
              onTap: (index) {
                print(index);
                provider.changePage(index);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.black,
                    size: 20,
                  ),
                  label: '',
                  activeIcon: Icon(
                    Icons.home,
                    size: 20,
                    color: Colors.amber,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.payment,
                    color: Colors.black,
                    size: 20,
                  ),
                  label: '',
                  activeIcon: Icon(
                    Icons.payment,
                    color: Colors.amber,
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
                    Icons.history,
                    color: Colors.black,
                    size: 20,
                  ),
                  label: '',
                  activeIcon: Icon(
                    Icons.history,
                    color: Colors.amber,
                    size: 20,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.black,
                    size: 20,
                  ),
                  label: '',
                  activeIcon: Icon(
                    Icons.settings,
                    color: Colors.amber,
                    size: 20,
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
  }
}
