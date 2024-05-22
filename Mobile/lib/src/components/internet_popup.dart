import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class InternetPopup extends StatelessWidget {
  static const router = 'error_popup';

  final String message;

  const InternetPopup(this.message, {Key? key}) : super(key: key);

  static void showErrorConnection(BuildContext context) async {
    final value = await Connectivity().checkConnectivity();

    if (value == ConnectivityResult.none) {
      // ignore: use_build_context_synchronously
      InternetPopup.show(context, "No Internet");
      return;
    }

    // ignore: use_build_context_synchronously
    InternetPopup.show(context, "Fail Server");
  }

  static Future show(BuildContext context, String message) {
    return showDialog(
      context: context,
      routeSettings: const RouteSettings(name: InternetPopup.router),
      barrierDismissible: true,
      builder: (_) => InternetPopup(message),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                child: const Icon(Icons.close),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: AppColors.blue_246BFD),
            ),
          ],
        ),
      ),
    );
  }
}
