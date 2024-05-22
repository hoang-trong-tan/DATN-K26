import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class SuccesPopup extends StatelessWidget {
  static const router = 'error_popup';

  final String message;

  const SuccesPopup(this.message, {Key? key}) : super(key: key);

  static void showErrorConnection(BuildContext context) async {
    final value = await Connectivity().checkConnectivity();

    if (value == ConnectivityResult.none) {
      // ignore: use_build_context_synchronously
      SuccesPopup.show(context, "No Internet");
      return;
    }

    // ignore: use_build_context_synchronously
    SuccesPopup.show(context, "Fail Server");
  }

  static ToastificationItem show(BuildContext context, String message) {
    return toastification.showCustom(
        context: context,
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.topCenter,
        builder: (BuildContext context, ToastificationItem holder) => SuccesPopup(message));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.green,
      ),
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle_outline_rounded,
            color: Colors.white,
            size: 30,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Thành công',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16)),
              const SizedBox(height: 8),
              Text(message,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400)),
              const SizedBox(height: 16),
            ],
          ),
        ],
      ),
    );
  }
}
