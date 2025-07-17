import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static customToastLong(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
  }

  static customToastShort(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
  }

  static customLog(String msg, {String name = 'custom_LOG'}) {
    if (kDebugMode) {
      log(msg, name: name);
    }
  }
}
