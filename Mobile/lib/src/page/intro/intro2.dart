import 'package:flutter/material.dart';
import 'package:kltn/src/page/intro/intro3.dart';
import 'package:kltn/src/utils/app_colors.dart';

import '../../base/di/locator.dart';
import '../../remote/local/shared_prefs.dart';
import '../main/main_page.dart';

class Intro2 extends StatelessWidget {
  const Intro2({super.key});

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
                      builder: (context) => MainPage(),
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
                child: Image.asset('assets/image/intro2.png'),
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
                      text: 'Giao diện',
                      style: TextStyle(color: Colors.black, height: 1.5),
                    ),
                    TextSpan(
                      text: ' thân thiện',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Giao diện người dùng dễ sử dụng, dễ nhìn.',
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
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
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Intro3(),
                        )),
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
