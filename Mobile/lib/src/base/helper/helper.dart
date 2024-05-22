import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class Helper {
  
  ///
  /// chuyển từ ngày database sang thời gian gần nhất
  /// 
  static String formatRelativeDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return "${difference.inSeconds} giây trước";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} phút trước";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} giờ trước";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} ngày trước";
    } else {
      int months = difference.inDays ~/ 30;
      return "$months tháng trước";
    }
  }

  ///
  /// chuyển từ giây sang phút:giây
  /// 
  static String convertMillisecondsToSeconds(double value) {
    int seconds = value.floor();
    int sec = seconds % 60;
    int min = (seconds / 60).floor();
    String minute = min.toString().padLeft(2, '0');
    String second = sec.toString().padLeft(2, '0');
    return "$minute:$second";
  }

  ///
  /// chuyển từ giây sang giờ:phút:giây
  /// 
  static String convertSecondsToMinute(int values) {
    int sec = values % 60;
    int min = (values / 60).floor();
    int hour = min ~/ 60; 
    String hours = hour.toString().length <= 1 ? "0$hour" : "$hour";
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$hours:$minute:$second";
  }
  
  ///
  /// chuyển giờ:phút:giây(04:02:12) sang giây
  /// 
  static int timeStringToSeconds(String timeString) {
    List<String> parts = timeString.split(':');
    int hours = int.parse(parts[0]);
    int minutes = int.parse(parts[1]);
    int seconds = int.parse(parts[2]);
    return ((hours * 60) + minutes) * 60 + seconds;
  }
    static Future<void> openBrowser(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      log('Could not open the url $url.');
    }
  }
}
