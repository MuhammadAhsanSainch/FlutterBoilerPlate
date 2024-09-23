import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppGlobals {
  ///
  /// VARIABLES
  ///
  // ApiService apiService = ApiService(dio.Dio(),AppUrl.apiUrl);
  static final GlobalKey<NavigatorState> appNavigationKey = GlobalKey<NavigatorState>();
  static bool isLogin = false;
  static String fcmToken = "";

  ///
  /// FUNCTIONS
  ///
  static Future<bool> internetConnectivityStatus() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        debugPrint('Internet Status = Connected');
        return true;
      } else {
        debugPrint('Internet Status = Not Connected');
        return false;
      }
    } on SocketException catch (_) {
      debugPrint('Internet Status = Not Connected');
      return false;
    }
  }

  static String getInitials(String bankAccountName) => bankAccountName.isNotEmpty ? bankAccountName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join() : '';

  //static const _chars = '1234567890';
  static final String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  static final Random _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  static DateTime parseToDateTime(String dateTime, String incomingFormat, String outgoingFormat) {
    var incomingDateTime = DateFormat(incomingFormat).parse(dateTime);
    var outgoingDateTime = DateFormat(outgoingFormat).parse(incomingDateTime.toString());
    return outgoingDateTime;
  }
}
