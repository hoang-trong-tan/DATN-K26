import 'package:flutter/material.dart';
import 'package:kltn/src/base/di/locator.dart';
import 'package:kltn/src/page/intro/intro2.dart';
import 'package:kltn/src/page/main/main_page.dart';
import 'package:kltn/src/remote/local/shared_prefs.dart';
import 'package:kltn/src/utils/app_colors.dart';


class Intro1 extends StatelessWidget {
  const Intro1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: GestureDetector(
              onTap: () {
                      locator<SharedPrefs>().intro = true;
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  MainPage(),
                          ),
                          (route) => false);
                    },
              child: const Text(
                'Bỏ qua',
                style: TextStyle(
                    color: AppColors.blue_246BFD,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
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
                child: Image.asset('assets/image/intro1.png'),
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
                      text: 'Bắt đầu khám phá',
                      style: TextStyle(color: Colors.black, height: 1.5),
                    ),
                    TextSpan(
                      text: ' khóa học \nngay',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Hãy tuân thủ giảng dạy để đạt hiệu quả tốt nhất',
                style: TextStyle(
                    color: AppColors.grayA2,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 55,
                        ),
                        Container(
                          height: 13,
                          width: 13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber,
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
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.amber.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Intro2(),
                          ));
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
