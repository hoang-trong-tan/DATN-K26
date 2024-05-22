import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:kltn/src/base/di/locator.dart';
import 'package:kltn/src/remote/local/shared_prefs.dart';
import 'package:http/http.dart' as http;

// class VNPAY {
//   static final VNPAY _instance = VNPAY();
//   static VNPAY get instance => _instance;

//   void show({
//     required String paymentUrl,
//     Function(Map<String, dynamic>)? onPaymentSuccess,
//     Function(Map<String, dynamic>)? onPaymentError,
//     Function()? onWebPaymentComplete,
//   }) async {
//     if (kIsWeb) {
//       await launchUrlString(
//         paymentUrl,
//         webOnlyWindowName: '_self',
//       );
//       if (onWebPaymentComplete != null) {
//         onWebPaymentComplete();
//       }
//     } else {
//       final FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
//       flutterWebviewPlugin.onUrlChanged.listen((url) async {
//         if (url.contains('vnp_ResponseCode')) {
//           final params = Uri.parse(url).queryParameters;
//           if (params['vnp_ResponseCode'] == '00') {
//             if (onPaymentSuccess != null) {
//               await http.get(Uri.parse(url));
//               onPaymentSuccess(params);
//             }
//           } else {
//             if (onPaymentError != null) {
//               onPaymentError(params);
//             }
//           }
//           flutterWebviewPlugin.close();
//         }
//       });
//       flutterWebviewPlugin.launch(paymentUrl);
//     }
//   }
// }

class WebviewScreen extends StatefulWidget {
  final String paymentUrl;
  final Function(Map<String, dynamic>)? onPaymentSuccess;
  final Function(Map<String, dynamic>)? onPaymentError;
  final Function()? onWebPaymentComplete;

  const WebviewScreen({
    Key? key,
    required this.paymentUrl,
    this.onPaymentSuccess,
    this.onPaymentError,
    this.onWebPaymentComplete,
  }) : super(key: key);

  @override
  WebviewScreenState createState() => WebviewScreenState();
}

class WebviewScreenState extends State<WebviewScreen> {
  double progress = 0;
  final prefs = locator<SharedPrefs>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Center(
            child: Text("Thanh toán"),
          ),
          automaticallyImplyLeading: false,
        ),
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.paymentUrl)),
          initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
              useShouldOverrideUrlLoading: true,
            ),
          ),
          onWebViewCreated: (controller) {
            controller.addJavaScriptHandler(
                handlerName: 'postMessage',
                callback: (args) {
                  final Map<String, dynamic> params = Map<String, dynamic>.from(args[0]);
                  if (params['vnp_ResponseCode'] == '00') {
                    if (widget.onPaymentSuccess != null) {
                      Navigator.pop(context, true);

                      widget.onPaymentSuccess!(params);
                    }
                  } else {
                    if (widget.onPaymentError != null) {
                      Navigator.pop(context);
                      widget.onPaymentError!(params);
                    }
                  }
                  if (widget.onWebPaymentComplete != null) {
                    widget.onWebPaymentComplete!();
                  }
                  Navigator.pop(context);
                });
          },
          onLoadError: (controller, url, code, message) async {
            final Map<String, dynamic> params = url!.queryParameters;
            if (params['vnp_ResponseCode'] == '00') {
              if (widget.onPaymentSuccess != null) {
                Navigator.pop(context, true);
                await http.get(url, headers: {'x-client-id': prefs.userID ?? '', 'x-atoken-id': prefs.token ?? ''});
                widget.onPaymentSuccess!(params);
              }
            } else {
              if (widget.onPaymentError != null) {
                Navigator.pop(context);
                widget.onPaymentError!(params);
              }
            }
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
        ),
      ),
    );
  }
}
