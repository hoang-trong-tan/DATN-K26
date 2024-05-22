import 'dart:developer';

import 'package:dio/dio.dart';

import '../../base/base_vm.dart';
import '../book_mark/book_mark_page.dart';
import '../home/home.dart';
import '../my_course/my_course.dart';
import '../profile/profile_page.dart';

class MainBoardVM extends BaseViewModel {
  //final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  int currentIndex = 0;
  bool select = true;

  final home = const HomePage();
  final myCourse = const MyCoursePage();
  final bookMark = const BookMarkPage();
  final profile = const ProfilePage();
  // final setting = SettingsPage();
  MainBoardVM() {
    log("MainBoardVM");
  }
  bool isLogin = true;

  @override
  void onInit() {
    // getSetting();
    log("token: ${prefs.token.toString()}");
    log("userid: ${prefs.userID.toString()}");
    if (prefs.token == null) {
      isLogin = false;
      notifyListeners();
    }
  }

  void changePage(int index) {
    currentIndex = index;

    notifyListeners();
  }

  ///
  /// theem gior hang
  ///
  Future addCart(String? idCourse) async {
    showLoading();
    try {
      final response =
          await api.apiServices.postCart(idCourse, {'x-atoken-id': prefs.token}, {'x-client-id': prefs.userID});
      if (response.status! >= 200 || response.status! < 400) {
        showSucces('Thêm vào danh sách yêu thích thành công');
        hideLoading();
      } else {
        showError('Không thể kết nối đến máy chủ.\nVui lòng thử lại.');
      }
      notifyListeners();
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      log(e.message.toString());
      if (e.response?.statusCode == 400) {
        showError('Khóa học đã tồn tại.');
      }
      hideLoading();
    }
  }

  // void onPageChanged(int index) {
  //   currentIndex = index;
  //   notifyListeners();
  // }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
//   Future<Position> determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Test if location services are enabled.
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error(S.current.services_disable);
//     }

//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error(S.current.location_permissions_denied);
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       return Future.error(S.current.permanent_denied_cannot_request);
//     }

//     // When we reach here, permissions are granted and we can
//     // continue accessing the position of the device.
//     return await Geolocator.getCurrentPosition();
//   }

//   void getCurrent() async {}

//   FutureOr getUser() {
//     showLoading();
//     api.accountServices.getUser().then((response) {
//       // Future nen dung then catch
//       final _appUser = response.data?.result ?? ProfileModel();
//       prefs.user = _appUser;
//       profileModel = _appUser;
//       hideLoading();
//       notifyListeners();
//     }).catchError((error) {
//       // loi nam o day, neu ko thanh cong se tim loi trong nay
//       hideLoading();
//       final message = error.message as String;
//       showError(message);
//       notifyListeners();
//     });
//   }

//   Future<void> init() async {
//     await FirebaseMessaging.instance.setAutoInitEnabled(true);

//     const channel = AndroidNotificationChannel(
//       'High Importance Notifications', // title
//       'This channel is used for important notifications.', // description
//       importance: Importance.high,
//     );
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(channel);

//     createLocalNotification();

//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     FirebaseMessaging.instance
//         .getInitialMessage()
//         .then((RemoteMessage? message) async {
//       if (message != null) {
//         if (kDebugMode) {
//           print("FirebaseMessaging.instance $message");
//         }

//         var data = message.data;
//         //wait after loading home api
//         await Future.delayed(const Duration(seconds: 5));
//         if (kDebugMode) {
//           print('MainHomeVM.init');
//         }
//         messageController.sink.add(null);
//       }
//     });

//     HandleMessage.handleMessage((RemoteMessage message) {
//       if (kDebugMode) {
//         print("FirebaseMessaging.onMessage.listen ${message.data}");
//       }
//       RemoteNotification? notification = message.notification;
//       if (notification != null && !kIsWeb) {
//         _showNotification(notification, message.data);
//       }
//       messageController.sink.add(null);
//     });

//     HandleMessage.handleMessageOpenedApp((RemoteMessage message) async {
//       if (kDebugMode) {
//         print('A new onMessageOpenedApp event was published!');
//         print(' FirebaseMessaging.onMessageOpenedApp.listen ${message.data}');
//       }
//       var data = message.data;
//     });

//     String? token = await FirebaseMessaging.instance.getToken();
//     final fcmToken = await FirebaseMessaging.instance.getToken();

//     print("token ==> $token");
//     print("token ==> $fcmToken");
//     prefs.deviceToken = token;
//   }

//   Future<void> createLocalNotification() async {
//     // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//         FlutterLocalNotificationsPlugin();
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('app_icon');
//     final DarwinInitializationSettings initializationSettingsDarwin =
//         DarwinInitializationSettings(
//             onDidReceiveLocalNotification: onDidReceiveLocalNotification);
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//             android: initializationSettingsAndroid,
//             iOS: initializationSettingsDarwin,
//             macOS: initializationSettingsDarwin);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
//   }

//   void onDidReceiveNotificationResponse(
//       NotificationResponse notificationResponse) async {
//     final String? payload = notificationResponse.payload;
//     if (notificationResponse.payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//   }

//   void onDidReceiveLocalNotification(
//       int id, String? title, String? body, String? payload) async {
//     // display a dialog with the notification details, tap ok to go to another page
//   }

//   Future<void> _showNotification(
//       RemoteNotification? notification, Map<String, dynamic> message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails('your channel id', 'your channel name',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker');
//     const NotificationDetails platformChannelSpecifics =
//         NotificationDetails(android: androidPlatformChannelSpecifics);
//     if (Platform.isIOS) {
//       final payload = jsonEncode(message);
//       try {
//         if (message['aps'] == null) {
//           var data = jsonDecode(message['payload']);
//           await flutterLocalNotificationsPlugin.show(
//               0, data['title'], data['message'], platformChannelSpecifics,
//               payload: payload);
//         } else {
//           await flutterLocalNotificationsPlugin.show(0, notification?.title,
//               notification?.body, platformChannelSpecifics,
//               payload: payload);
//         }
//       } catch (e) {
//         if (kDebugMode) {
//           print("ERROR NOTIFICATION IOS");
//         }
//       }
//     }
//     //ANDROID
//     else {
//       try {
//         final payload = jsonEncode(message);
//         await flutterLocalNotificationsPlugin.show(0, notification?.title ?? '',
//             notification?.body ?? '', platformChannelSpecifics,
//             payload: payload);
//       } catch (e) {
//         if (kDebugMode) {
//           print("ERROR NOTIFICATION ANDROID");
//         }
//       }
//     }
//   }

  // Future<void> getSetting() async {
  //   try {
  //     final response = await api.authServices.getSetting();
  //     notifyListeners();
  //   } on DioException catch (e) {
  //     hideLoading();
  //   }
  // }
}
