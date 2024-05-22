import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kltn/src/base/base_page.dart';
import 'package:kltn/src/page/splash/splash_vm.dart';
import '../../utils/app_colors.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with MixinBasePage<SplashVM> {
  @override
  Widget build(BuildContext context) {
    return builder(() {
      provider.checkIntol(context);
      return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Column(
                  children: [
                    SizedBox(height: 50, width: 50, child: Image.asset('assets/image/logo.png')),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'K26-Demy',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(16)),
                    child: const SpinKitCircle(size: 40, color: AppColors.blue_246BFD)),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  SplashVM create() {
    return SplashVM();
  }

  @override
  void initialise(BuildContext context) {
    // provider.checkIntol(context);
  }
}
