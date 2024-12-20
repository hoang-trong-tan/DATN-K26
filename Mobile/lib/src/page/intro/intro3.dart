import 'package:flutter/material.dart';
import 'package:kltn/src/page/main/main_page.dart';
import 'package:kltn/src/utils/app_colors.dart';

import '../../base/di/locator.dart';
import '../../remote/local/shared_prefs.dart';

class Intro3 extends StatelessWidget {
  const Intro3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, actions: const [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              '',
              style: TextStyle(color: AppColors.blue_246BFD, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        )
      ]),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('assets/image/intro3.png'),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(
                      text: 'Đa lĩnh vực,',
                      style: TextStyle(color: Colors.black, height: 1.5),
                    ),
                    TextSpan(
                      text: ' đa đối tượng',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Các khóa học đa dạng lĩnh vực hướng đến tất cả mọi người',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.grayA2, fontSize: 14, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: AppColors.blue_246BFD),
                        color: AppColors.white,
                      ),
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: AppColors.blue_246BFD,
                        size: 30,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber.withOpacity(0.3),
                    ),
                  ),
                  const SizedBox(width: 13),
                  Container(
                    height: 13,
                    width: 13,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.amber,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      locator<SharedPrefs>().intro = true;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainPage(),
                          ),
                          (route) => false);
                    },
                    child: Container(
                      height: 55,
                      width: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: AppColors.blue_246BFD,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
