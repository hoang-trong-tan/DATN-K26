import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:kltn/src/utils/app_colors.dart';

import 'firebase_options.dart';
import 'src/base/di/locator.dart';
import 'src/base/fcm/fcm_firebase.dart';
import 'src/base/fcm/local_notification_service.dart';
import 'src/page/splash/splash.dart';
import 'src/remote/local/shared_prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool check = false;
  setUpInjector();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await locator<SharedPrefs>().initialise();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;

  runApp(const MyApp());
  await FcmService().init();
  await FcmService().initForegroundNotification();
  await LocalNotificationService().init();
  FcmService().backgroundHandler();
  // if (locator<SharedPrefs>().fcmToken == null) {
  final tokenFcm = await messaging.getToken();
  locator<SharedPrefs>().fcmToken = tokenFcm;
  log("token_fcm:$tokenFcm");
  // }
  InternetConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        if (check) {
          Fluttertoast.showToast(
            msg: 'Đã khôi phục kết nối internet',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.white,
            textColor: AppColors.blue_246BFD,
            fontSize: 16.0,
          );
        }

        break;
      case InternetConnectionStatus.disconnected:
        Fluttertoast.showToast(
          msg: 'không có kết nối internet',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white,
          textColor: AppColors.blue_246BFD,
          fontSize: 16.0,
        );

        check = true;
        break;
    }
  });

  // Custom Toast Position

  // // close listener after 30 seconds, so the program doesn't run forever
//   await Future.delayed(const Duration(seconds: 3));
//   await listener.cancel();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K26-Demy',
      theme: ThemeData(

          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          // useMaterial3: true,
          ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('vi', 'VN'),
      ],
      home: const Splash(),
      locale: const Locale('vi', "VN"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
